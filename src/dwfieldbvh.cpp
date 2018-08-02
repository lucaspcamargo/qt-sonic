#include "dwfieldbvh.h"
#include "dwfieldbvhnode.h"
#include <QVector2D>
#include <QList>

#include <QDebug>


dwFieldBVH::dwFieldBVH(QObject *parent) : QObject(parent)
{
    m_rootNode = new dwFieldBVHNode(0);
    m_activateAll = false;
    m_viewCenterX = 0;
    m_viewCenterY = 0;
    m_viewRadius = 300;

    m_maxChildNodes = 8;
}

dwFieldBVH::~dwFieldBVH()
{
    delete m_rootNode;

}

dwFieldBVHNode *dwFieldBVH::createNode(qreal xC, qreal yC, qreal radius, dwFieldBVHNode *parent)
{
    dwFieldBVHNode * node = new dwFieldBVHNode(parent);
    node->setCenterX(xC);
    node->setCenterY(yC);
    node->setRadius(radius);

    return node;

}

void dwFieldBVH::update(qreal dt)
{
    Q_UNUSED(dt)
    updateNode(m_rootNode);
}

void dwFieldBVH::updateNode(dwFieldBVHNode *node)
{
    bool nodeActiveNow = false;
    if(m_activateAll) nodeActiveNow = true;
    else nodeActiveNow = QVector2D(m_viewCenterX - node->centerX(), m_viewCenterY - node->centerY() ).length() < (m_viewRadius + node->radius());

    if(nodeActiveNow || ((!nodeActiveNow) && node->active()))
    {
        foreach (QObject * obj, node->children())
        {
            dwFieldBVHNode * childNode = static_cast<dwFieldBVHNode * >(obj);
            if(nodeActiveNow)
                updateNode(childNode);
            else
                childNode->setHierarchyInactive();
        }
    }

    node->setActive(nodeActiveNow);
}

bool nodeXLessThan( const dwFieldBVHNode * node1, const dwFieldBVHNode * node2 )
{
    return node1->centerX() < node2->centerX();
}
bool nodeYLessThan( const dwFieldBVHNode * node1, const dwFieldBVHNode * node2 )
{
    return node1->centerY() < node2->centerY();
}


int buildBVHNode(dwFieldBVHNode * node, int maxChildNodes)
{
    int depth = 1;

    //qDebug() << "Build BVH Node: " << node->children().length() << " children";

    if(node->children().length() > maxChildNodes)
    {
        // lets split the node
        QList<dwFieldBVHNode *> nodeChildren;
        foreach (QObject * obj, node->children())
        {
            nodeChildren.append(static_cast<dwFieldBVHNode * >(obj));
        }

        qreal xSize, ySize;
        xSize = node->getXExtent();
        ySize = node->getYExtent();

        qSort(nodeChildren.begin(), nodeChildren.end(), (xSize >= ySize)? nodeXLessThan : nodeYLessThan );
        //qDebug(QString("%1 : %2").arg(xSize).arg(ySize).toLocal8Bit());

        dwFieldBVHNode *node1 = new dwFieldBVHNode(node);
        dwFieldBVHNode *node2 = new dwFieldBVHNode(node);

        for(int i = 0; i < nodeChildren.length(); i++)
        {
            nodeChildren[i]->setParent( i < (nodeChildren.length()/2)? node1 : node2 );
            //qDebug(i < (nodeChildren.length()/2)? "A" : "B");
        }

        int depth1 = buildBVHNode(node1, maxChildNodes);
        int depth2 = buildBVHNode(node2, maxChildNodes);

        depth = qMax(depth1, depth2) + 1;
    }

    node->recalcGeometry();

    //qDebug() << "My depth is " << depth;

    return depth;
}

int dwFieldBVH::buildBVH(dwFieldBVHNode * node)
{

    qDebug() << "[dwFieldBVH] buildBVH() processing " << node->children().length() << " nodes";

    int depth = buildBVHNode(node, m_maxChildNodes);

    qDebug() << "[dwFieldBVH] tree depth was" << depth;

    return depth;
}

void findLeafNodes(dwFieldBVHNode *node, QList<dwFieldBVHNode*> *list)
{
    if(node->children().size() == 0)
        list->append(node);
    else
    {
        foreach (QObject * obj, node->children())
        {
            dwFieldBVHNode *child = static_cast<dwFieldBVHNode * >(obj);
            findLeafNodes(child, list);
        }
    }
}


void dwFieldBVH::flattenBVH(dwFieldBVHNode *node)
{
    QList<dwFieldBVHNode*> leafNodes;
    QList<dwFieldBVHNode*> nonLeafNodes;

    // find all leaf nodes
    if(node->children().size()) // test so that root node is not added as a leaf node
        findLeafNodes(node, &leafNodes);

    //reparent all leaf nodes
    foreach (dwFieldBVHNode *leafNode, leafNodes) {
        leafNode->setParent(node);
    }

    // delete all children that are not a leaf node
    foreach (QObject * obj, node->children())
    {
        dwFieldBVHNode *child = static_cast<dwFieldBVHNode * >(obj);

        if(leafNodes.contains(child)) continue;

        nonLeafNodes.append(child);
        child->setParent(0); // disassemble the node hierarchy
    }

    foreach (dwFieldBVHNode *nonLeaf, nonLeafNodes)
    {
        delete nonLeaf;
    }


}

void dwFieldBVH::rebuildBVH()
{
    qDebug() << "[dwFieldBVH] Rebuilding BVH";
    flattenBVH(rootNode());
    buildBVH(rootNode());
}



