#include "dwfieldbvh.h"
#include "dwfieldbvhnode.h"
#include <QVector2D>

dwFieldBVH::dwFieldBVH(QObject *parent) : QObject(parent)
{
    m_rootNode = new dwFieldBVHNode(0);
    m_activateAll = false;
    m_viewCenterX = 0;
    m_viewCenterY = 0;
    m_viewRadius = 300;
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
            dwFieldBVHNode * childNode = reinterpret_cast<dwFieldBVHNode * >(obj);
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

void dwFieldBVH::buildBVH(int maxNodes, dwFieldBVHNode * node)
{
    if(node->children().length() > maxNodes)
    {
        // lets split the node
        QList<dwFieldBVHNode *> nodeChildren;
        foreach (QObject * obj, node->children())
        {
            nodeChildren.append(reinterpret_cast<dwFieldBVHNode * >(obj));
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
        }

        buildBVH(maxNodes, node1);
        buildBVH(maxNodes, node2);
    }

    node->recalcGeometry();
}

