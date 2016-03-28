#ifndef DWFXWATER_H
#define DWFXWATER_H

#include <QQuickItem>
#include <QSGSimpleMaterialShader>
#include <QSGGeometryNode>

struct dwFxWaterMaterialState {
    QColor waterColor;
};

class dwFxWaterMaterial: public QSGMaterialShader
{
    QSG_DECLARE_SIMPLE_SHADER(dwFxWaterMaterial, dwFxWaterMaterialState)
    public:

        const char *vertexShader() const {
            return
                    "attribute highp vec4 aVertex;                              \n"
                    "attribute highp vec2 aTexCoord;                            \n"
                    "uniform highp mat4 qt_Matrix;                              \n"
                    "varying highp vec2 texCoord;                               \n"
                    "void main() {                                              \n"
                    "    gl_Position = qt_Matrix * aVertex;                     \n"
                    "    texCoord = aTexCoord;                                  \n"
                    "}";
        }

        const char *fragmentShader() const {
            return
                    "uniform lowp float qt_Opacity;                             \n"
                    "uniform lowp vec4 waterColor;                              \n"
                    "varying highp vec2 texCoord;                               \n"
                    "void main ()                                               \n"
                    "{                                                          \n"
                    "    gl_FragColor = waterColor * qt_Opacity;  \n"
                    "}";
        }

        char const *const *attributeNames() const
        {
          static char const *const names[] = { "aVertex", "aTexCoord", 0 };
          return names;
        }

        void initialize()
        {
            QSGMaterialShader::initialize();
            m_id_matrix = program()->uniformLocation("qt_Matrix");
            m_id_opacity = program()->uniformLocation("qt_Opacity");
            id_color = program()->uniformLocation("waterColor");
        }

        void updateState(const RenderState &state, QSGMaterial *newMaterial, QSGMaterial *oldMaterial)
        {
            Q_ASSERT(program()->isLinked());
            if (state.isMatrixDirty())
                program()->setUniformValue(m_id_matrix, state.combinedMatrix());
            if (state.isOpacityDirty())
                program()->setUniformValue(m_id_opacity, state.opacity());
            program()->setUniformValue(id_color, static_cast<QSGSimpleMaterial<dwFxWaterMaterialState>*>(newMaterial)->state()->waterColor);
        }

        void activate();

        void deactivate();

    private:
        int m_id_matrix;
        int m_id_opacity;
        int id_color;
};

class dwFxWaterNode : public QSGGeometryNode
{
public:
    dwFxWaterNode()
        : m_geometry(QSGGeometry::defaultAttributes_TexturedPoint2D(), 4)
    {
        setGeometry(&m_geometry);

        QSGSimpleMaterial<dwFxWaterMaterialState> *material = dwFxWaterMaterial::createMaterial();
        material->setFlag(QSGMaterial::Blending);
        setMaterial(material);
        setFlag(OwnsMaterial);
    }

    QSGGeometry m_geometry;
};

class dwFxWater : public QQuickItem
{
    Q_OBJECT
    Q_PROPERTY(QColor color READ color WRITE setColor NOTIFY colorChanged)
public:
    explicit dwFxWater(QQuickItem *parent = 0);

    void setColor(const QColor &color) {
        if (m_color != color) {
            m_color = color;
            emit colorChanged();
            update();
        }
    }
    QColor color() const {
        return m_color;
    }

     QSGNode *updatePaintNode(QSGNode *node, UpdatePaintNodeData *);

signals:
    void colorChanged();

private:
  QColor m_color;

};

#endif // DWFXWATER_H
