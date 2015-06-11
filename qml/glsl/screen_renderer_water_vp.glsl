uniform highp mat4 qt_Matrix;
attribute highp vec4 qt_Vertex;
attribute highp vec2 qt_MultiTexCoord0;
varying highp vec2 coord;
uniform highp float waterLevel;

void main() {

    coord = vec2(qt_MultiTexCoord0.x, waterLevel + qt_MultiTexCoord0.y*(1.0-waterLevel));
    gl_Position = qt_Matrix * qt_Vertex;

}
