varying highp vec2 coord;
uniform lowp float fgScale;
uniform lowp float bgScale;
uniform lowp float displacement;

uniform sampler2D src;
uniform sampler2D refl;
uniform lowp float underwaterMix;
uniform lowp vec4 coloring;
void main()
{
    lowp vec2 coord2 = (coord-vec2(0.5, 0)) * vec2(mix(bgScale, fgScale, coord.y), 1 ) + vec2(displacement, 0);
    lowp vec4 tex = texture2D(src, vec2(mod(coord2.x, 1.0), mod(coord2.y, 1.0)) );
    lowp vec3 color = min( vec3(1.0), max(vec3(0.0), tex.rrr + coloring.rgb));
    gl_FragColor = vec4( color, 1.0) * (0.5+(coord.y)*0.5);

}
