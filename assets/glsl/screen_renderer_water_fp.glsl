varying highp vec2 coord;
uniform sampler2D src;
uniform lowp float waterLevel;
uniform lowp float time;
uniform lowp float invScreenWidth;
uniform lowp float waveYDelta;
uniform lowp vec4 waterColor;
void main() {
if(coord.y > waterLevel)
{
    lowp vec4 tex = texture2D(src, vec2(coord.x + cos(time+waveYDelta+10.0*coord.y)*invScreenWidth, coord.y))*waterColor;
    gl_FragColor = tex;
}else{
    lowp vec4 tex = texture2D(src, coord);
    gl_FragColor = tex;
}
}