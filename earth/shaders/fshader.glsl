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
    
    vec4 L = normalize((ModelViewLight * LightPosition) - pos);
    float Kd = max(dot(normalize(N.xyz), L.xyz), 0.0);

    
    vec4 dayColor = texture(textureEarth, texCoord);
    vec4 nightColor = texture(textureNight, texCoord);
    vec4 cloudColor = texture(textureCloud, texCoord);
    vec4 noise = texture(texturePerlin, texCoord * 2.0); /


    float blendFactor = Kd * 0.7 + 0.3 * noise.r;
    
 
    vec4 baseColor = mix(nightColor, dayColor, blendFactor);

    
    vec4 mixedColor = mix(baseColor, cloudColor, 0.4 * (0.5 + 0.5 * noise.r));

    // Final color output with ambient lighting
    fragColor = ambient + mixedColor;
    fragColor = clamp(fragColor, 0.0, 1.0);
    fragColor.a = 1.0;
}
