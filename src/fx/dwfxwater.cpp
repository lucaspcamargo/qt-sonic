#include "dwfxwater.h"

void dwFxWaterMaterial::activate()
{
    QSGMaterialShader::activate();
    glBlendFunc(GL_DST_COLOR, GL_ZERO);
}

void dwFxWaterMaterial::deactivate()
{
    glBlendFunc(GL_ONE, GL_ONE_MINUS_SRC_ALPHA);
    QSGMaterialShader::deactivate();
}

dwFxWater::dwFxWater(QQuickItem *parent):
QQuickItem(parent)
{
    setFlag(ItemHasContents, true);
}

QSGNode * dwFxWater::updatePaintNode(QSGNode *node, QQuickItem::UpdatePaintNodeData * u)
{
    dwFxWaterNode *n = static_cast<dwFxWaterNode *>(node);
    if (!node)
        n = new dwFxWaterNode();

    QSGGeometry::updateTexturedRectGeometry(n->geometry(), boundingRect(), QRectF(0, 0, 1, 1));
    static_cast<QSGSimpleMaterial<dwFxWaterMaterialState>*>(n->material())->state()->waterColor = m_color;

    n->markDirty(QSGNode::DirtyGeometry | QSGNode::DirtyMaterial);

    return n;
}
