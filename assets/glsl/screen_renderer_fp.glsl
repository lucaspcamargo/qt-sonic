varying highp vec2 coord;
uniform sampler2D src;
void main() {
    lowp vec4 tex = texture2D(src, coord);
    gl_FragColor = tex;

}