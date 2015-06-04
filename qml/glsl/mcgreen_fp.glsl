uniform highp vec2 texture_size;
uniform sampler2D decal;
varying highp vec2 texCoord;

// number of colors the display can show
const float colors = 8.0;
const vec3 ink = vec3(0.32, 0.50, 0.0);
const vec3 lum = vec3(0.299,0.587,0.114);

void main()
{
       vec3 c11 = texture2D(decal, texCoord.xy).xyz;
       float lct = floor(colors*dot(c11, lum))/colors;

       gl_FragColor = vec4(lct*ink,1);
}

