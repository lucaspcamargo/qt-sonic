uniform highp mat4 qt_Matrix;
attribute highp vec4 qt_Vertex;
attribute highp vec2 qt_MultiTexCoord0;

varying mediump vec4 tx0;
varying mediump vec4 tx1;
varying mediump vec4 tx2;
varying mediump vec4 tx3;
varying mediump vec4 tx4;
varying mediump vec4 tx5;
varying mediump vec4 tx6;
varying mediump vec4 tx7;

uniform lowp vec2 rubyTextureSize;

void main() {

    float dx = 1.0 / rubyTextureSize.x;

    float dy = 1.0 / rubyTextureSize.y;

    //     A1 B1 C1

    //  A0  A  B  C C4

    //  D0  D  E  F F4

    //  G0  G  H  I I4

    //     G5 H5 I5

    gl_Position = qt_Matrix * qt_Vertex;

    tx0 = qt_MultiTexCoord0.xyxy;

    tx1 = qt_MultiTexCoord0.xxxy + vec4(    -dx,   0,  dx, -2.0*dy);  //  A1 B1 C1

    tx2 = qt_MultiTexCoord0.xxxy + vec4(    -dx,   0,  dx,     -dy);  //   A  B  C

    tx3 = qt_MultiTexCoord0.xxxy + vec4(    -dx,   0,  dx,       0);  //   D  E  F

    tx4 = qt_MultiTexCoord0.xxxy + vec4(    -dx,   0,  dx,      dy);  //   G  H  I

    tx5 = qt_MultiTexCoord0.xxxy + vec4(    -dx,   0,  dx,  2.0*dy);  //  G5 H5 I5

    tx6 = qt_MultiTexCoord0.xyyy + vec4(-2.0*dx, -dy,   0,      dy);  //  A0 D0 G0

    tx7 = qt_MultiTexCoord0.xyyy + vec4( 2.0*dx, -dy,   0,      dy);  //  C4 F4 I4

}
