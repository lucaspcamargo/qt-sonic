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


dwFxWaterNode::dwFxWaterNode()
{

    int vmesh = 2;
    int hmesh = 50;

    int positionIndex = 0;
    int attrCount = 2;

    m_geometry = new QSGGeometry(QSGGeometry::defaultAttributes_TexturedPoint2D(),
                               (vmesh + 1) * (hmesh + 1), vmesh * 2 * (hmesh + 2),
                               GL_UNSIGNED_SHORT);

    QSGGeometry::Point2D *vdata = static_cast<QSGGeometry::Point2D *>(m_geometry->vertexData());

    QRectF srcRect(0, 0, 1, 1);
    QRectF dstRect(0, 0, 500, 4000);

    for (int iy = 0; iy <= vmesh; ++iy) {
        float fy = iy / float(vmesh);
        float y = float(dstRect.top()) + fy * float(dstRect.height());
        float ty = float(srcRect.top()) + fy * float(srcRect.height());
        for (int ix = 0; ix <= hmesh; ++ix) {
            float fx = ix / float(hmesh);
            for (int ia = 0; ia < attrCount; ++ia) {
                if (ia == positionIndex) {
                    vdata->x = float(dstRect.left()) + fx * float(dstRect.width());
                    vdata->y = y;
                    ++vdata;
                } else {
                    vdata->x = float(srcRect.left()) + fx * float(srcRect.width());
                    vdata->y = ty;
                    ++vdata;
                }
            }
        }
    }

    quint16 *indices = (quint16 *)m_geometry->indexDataAsUShort();
    int i = 0;
    for (int iy = 0; iy < vmesh; ++iy) {
        *(indices++) = i + hmesh + 1;
        for (int ix = 0; ix <= hmesh; ++ix, ++i) {
            *(indices++) = i + hmesh + 1;
            *(indices++) = i;
        }
        *(indices++) = i - 1;
    }

    setGeometry(m_geometry);
    setFlag(OwnsGeometry);

    QSGSimpleMaterial<dwFxWaterMaterialState> *material = dwFxWaterMaterial::createMaterial();
    material->setFlag(QSGMaterial::Blending);
    setMaterial(material);
    setFlag(OwnsMaterial);
}


QSGNode * dwFxWater::updatePaintNode(QSGNode *node, QQuickItem::UpdatePaintNodeData * u)
{
    Q_UNUSED(u)

    dwFxWaterNode *n = static_cast<dwFxWaterNode *>(node);
    if (!node)
    {
        n = new dwFxWaterNode();

        // geometry is hardcoded in the node
        //QSGGeometry::updateTexturedRectGeometry(n->geometry(), boundingRect(), QRectF(0, 0, 1, 1));

    }

    static_cast<QSGSimpleMaterial<dwFxWaterMaterialState>*>(n->material())->state()->waterColor = m_color;
    static_cast<QSGSimpleMaterial<dwFxWaterMaterialState>*>(n->material())->state()->time = m_time;
    static_cast<QSGSimpleMaterial<dwFxWaterMaterialState>*>(n->material())->state()->xpos= x();

    n->markDirty(QSGNode::DirtyGeometry | QSGNode::DirtyMaterial);

    return n;
}
