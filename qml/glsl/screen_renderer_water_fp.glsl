varying highp vec2 coord;
uniform sampler2D src;
uniform highp float waterLevel;
uniform lowp float time;
uniform lowp float invScreenWidth;
uniform lowp float chromatic;
uniform lowp vec4 waterColor;

#define GFX_HIGH

void main() {

    mediump vec2 newCoord = vec2(coord.x + cos(time+10.0*coord.y)*invScreenWidth, coord.y );

    mediump vec2 v = vec2(0.5, 0.5)-newCoord;

    lowp vec4 texr = texture2D(src, newCoord + chromatic * v * invScreenWidth);
    lowp vec4 texb = texture2D(src, newCoord - chromatic * v * invScreenWidth);
// the commented section here uses only two samples on mobile
//#ifdef GL_ES
//    gl_FragColor = vec4(texr.r, (texr.g + texb.g)/2.0, texb.b, 1.0) * waterColor;
//#else
#ifdef GFX_HIGH
    lowp vec4 texrg = texture2D(src, newCoord + chromatic * 0.5 * v * invScreenWidth);
    lowp vec4 texgb = texture2D(src, newCoord - chromatic * 0.5 * v * invScreenWidth);
    lowp vec4 texg = texture2D(src, newCoord);
    gl_FragColor = vec4((texr.r + texrg.r)/2.0, (texrg.g + texg.g + texgb.g) / 3.0, (texgb.b + texb.b)/2.0, 1.0) * waterColor;
#else
    lowp vec4 texg = texture2D(src, newCoord);
    gl_FragColor = vec4(texr.r, texg.g, texb.b, 1.0) * waterColor;
#endif
//#endif
}
