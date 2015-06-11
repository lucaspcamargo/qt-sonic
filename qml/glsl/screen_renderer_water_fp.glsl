varying highp vec2 coord;
uniform sampler2D src;
uniform highp float waterLevel;
uniform lowp float time;
uniform lowp float invScreenWidth;
uniform lowp float chromatic;
uniform lowp vec4 waterColor;

void main() {

    vec2 newCoord = vec2(coord.x + cos(time+10.0*coord.y)*invScreenWidth, coord.y );

    vec2 v = vec2(0.5, 0.5)-newCoord;

    lowp vec4 texr = texture2D(src, newCoord + chromatic * v * invScreenWidth);
    lowp vec4 texb = texture2D(src, newCoord - chromatic * v * invScreenWidth);
#ifdef GL_ES
    gl_FragColor = vec4(texr.r, (texr.g + texb.g)/2.0, texb.b, 1.0) * waterColor;
#else
    lowp vec4 texg = texture2D(src, newCoord);
    gl_FragColor = vec4(texr.r, texg.g, texb.b, 1.0) * waterColor;
#endif
}
