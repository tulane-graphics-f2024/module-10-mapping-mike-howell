#version 150

uniform vec4 ambient;
uniform vec4 LightPosition;

in vec4 pos;
in vec4 N;
in vec2 texCoord;

uniform mat4 ModelViewLight;

uniform sampler2D textureEarth;
uniform sampler2D textureNight;
uniform sampler2D textureCloud;
uniform sampler2D texturePerlin;

uniform float animate_time;


out vec4 fragColor;

void main()
{
  vec3 L = normalize( (ModelViewLight*LightPosition).xyz - pos.xyz );
  
  float Kd = 1.0;
  
    
    
  vec4 diffuse = texture(textureEarth, texCoord );
  diffuse = Kd*diffuse;
  
  vec4 cloud_color = texture(textureCloud, texCoord);
  vec4 cloud_blend = diffuse + cloud_color * 0.5;
  cloud_blend = clamp(cloud_blend, 0.0, 1.0);
    
  float diffuse_intensity = max(dot(N.xyz, L), 0.0);
  vec4 diffuselight = diffuse_intensity * cloud_blend;
  fragColor = ambient + cloud_blend + diffuselight;
  fragColor = clamp(fragColor, 0.0, 1.0);
  fragColor.a = 1.0;
}
