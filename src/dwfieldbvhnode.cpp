#include "dwfieldbvhnode.h"
#include <QVector2D>
#include <QtMath>

dwFieldBVHNode::dwFieldBVHNode(dwFieldBVHNode *parent) : QObject(parent)
{
    m_active = true;
    if(parent){
        m_centerX = parent->centerX();
        m_centerY = parent->centerY();
    }
    else
    {
        m_centerX = m_centerY = 0;
    }

    m_radius = 0;

}

dwFieldBVHNode::~dwFieldBVHNode()
{

}

#include <QChildEvent>

void dwFieldBVHNode::childEvent(QChildEvent *e)
{
    if(e->added())
    {
        dwFieldBVHNode * child = static_cast<dwFieldBVHNode*>(e->child());
        if(!m_active) child->setActive(false);
    }
}

void dwFieldBVHNode::recalcGeometry()
{
    qreal xC = 0;
    qreal yC = 0;

    int childCount = children().length();

    if(childCount)
    {
        foreach (QObject * obj, children()) {
            dwFieldBVHNode * node = static_cast<dwFieldBVHNode * >(obj);
            xC += node->centerX();
            yC += node->centerY();
        }

        xC /= childCount;
        yC /= childCount;
    }

    setCenterX(xC);
    setCenterY(yC);

    qreal maxRadius = 0;

    foreach (QObject * obj, children()) {
        dwFieldBVHNode * node = static_cast<dwFieldBVHNode * >(obj);
        maxRadius = qMax(maxRadius, QVector2D(m_centerX - node->centerX(), m_centerY - node->centerY()).length() + node->radius());
    }

    setRadius(maxRadius);
}

void dwFieldBVHNode::disconnectActivationSignals()
{
    disconnect(this, &dwFieldBVHNode::activated, 0, 0);
    disconnect(this, &dwFieldBVHNode::deactivated, 0, 0);
}

qreal dwFieldBVHNode::getXExtent()
{
    if(children().empty()) return 0.0;

    qreal minX = 1.0e10;
    qreal maxX = 1.0e-10;
    foreach (QObject * obj, children()) {
        dwFieldBVHNode * node = static_cast<dwFieldBVHNode * >(obj);
        minX = qMin(minX, node->centerX() - node->radius());
        maxX = qMax(maxX, node->centerX() + node->radius());
    }

    return maxX - minX;
}


qreal dwFieldBVHNode::getYExtent()
{
    if(children().empty()) return 0.0;

    qreal minY = 1.0e10;
    qreal maxY = 1.0e-10;
    foreach (QObject * obj, children()) {
        dwFieldBVHNode * node = static_cast<dwFieldBVHNode * >(obj);
        minY = qMin(minY, node->centerY() - node->radius());
        maxY = qMax(maxY, node->centerY() + node->radius());
    }

    return maxY - minY;

}

void dwFieldBVHNode::markForDeletion()
{
    deleteLater();
}
