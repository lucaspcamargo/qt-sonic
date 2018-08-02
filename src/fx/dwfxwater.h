#ifndef DWFXWATER_H
#define DWFXWATER_H

#include <QQuickItem>
#include <QSGSimpleMaterialShader>
#include <QSGGeometryNode>

struct dwFxWaterMaterialState {
    QColor waterColor;
    qreal time;
    qreal xpos;
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
                    "uniform mediump float time;\n"
                    "uniform highp float xpos;\n"
                    "void main() {                                              \n"
                    "    texCoord = aTexCoord;                                  \n"
                    "    float worldPos = xpos + 500.0 * texCoord.x;"
                    "    float sinarg = 0.1*(worldPos) + time*5.0;"
                    "    float timeAlpha = (1.0 + sin(time * 4.0))*0.5;"
                    "    gl_Position = qt_Matrix * (aVertex + vec4(0.0, 2.5 * mix(sin(sinarg), -sin(sinarg), timeAlpha), 0.0, 0.0) );"
                    "    //gl_Position = qt_Matrix * aVertex;                     \n"
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
            id_time = program()->uniformLocation("time");
            id_xpos = program()->uniformLocation("xpos");
        }

        void updateState(const RenderState &state, QSGMaterial *newMaterial, QSGMaterial *oldMaterial)
        {
            Q_ASSERT(program()->isLinked());
            Q_UNUSED(oldMaterial)

            if (state.isMatrixDirty())
                program()->setUniformValue(m_id_matrix, state.combinedMatrix());
            if (state.isOpacityDirty())
                program()->setUniformValue(m_id_opacity, state.opacity());
            program()->setUniformValue(id_color, static_cast<QSGSimpleMaterial<dwFxWaterMaterialState>*>(newMaterial)->state()->waterColor);
            program()->setUniformValue(id_time, (GLfloat)static_cast<QSGSimpleMaterial<dwFxWaterMaterialState>*>(newMaterial)->state()->time);
            program()->setUniformValue(id_xpos, (GLfloat)static_cast<QSGSimpleMaterial<dwFxWaterMaterialState>*>(newMaterial)->state()->xpos);
        }

        void activate();

        void deactivate();

    private:
        int m_id_matrix;
        int m_id_opacity;
        int id_color;
        int id_time;
        int id_xpos;
};

class dwFxWaterNode : public QSGGeometryNode
{
public:

    dwFxWaterNode();

    QSGGeometry * m_geometry;
};

class dwFxWater : public QQuickItem
{
    Q_OBJECT
    Q_PROPERTY(QColor color READ color WRITE setColor NOTIFY colorChanged)
    Q_PROPERTY(qreal time READ time WRITE setTime NOTIFY timeChanged)
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

     qreal time() const
     {
         return m_time;
     }


public slots:
     void setTime(qreal time)
     {
         if (m_time == time)
             return;

         m_time = time;
         emit timeChanged(time);
         update();
     }

signals:
    void colorChanged();

    void timeChanged(qreal time);


private:
  QColor m_color;

  qreal m_time;
  qreal m_xpos;
};

#endif // DWFXWATER_H
