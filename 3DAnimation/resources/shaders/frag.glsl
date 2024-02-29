//
//  main.glsl
//  3DAnimation
//
//  Created by GoodDamn on 06/02/2024.
//

precision mediump float;

varying lowp vec2 texCoordOut;
varying lowp vec3 normalOut;
varying lowp vec3 positionOut;

uniform sampler2D texture;

uniform highp float specularIntensity;
uniform highp float shininess;

struct DirLight {
    lowp vec3 color;
    lowp float ambient;
    lowp float diffIntensity;
    lowp vec3 direction;
};

struct PointLight {
    vec3 position;
    
    float constant;
    float linear;
    float quadratic;
    
    vec3 ambient;
    vec3 diffuse;
    vec3 specular;
};

#define POINT_LIGHTS 4

uniform PointLight pointLights[POINT_LIGHTS];

uniform DirLight light;

/*vec3 calcPointLight(
    PointLight light,
    vec3 normal,
    vec3 fragPos,
    vec3 viewDir
) {
    
    vec3 lightDir = normalize(light.position - fragPos);
    
    float diff = max(dot(normal, lightDir),0.0);
    
    vec3 reflectDir = reflect(-lightDir, normal);
    
    //float spec = pow(max(dot(viewDir,reflectDir),0.0), )
}*/

void main() {
    
    // Ambient
    lowp vec3 ambColor = light.color * light.ambient;
    
    // Diffuse
    lowp vec3 normal = normalize(normalOut);
    lowp float difFactor = max(-dot(normal, light.direction), 0.0);
    lowp vec3 difColor = light.color * light.diffIntensity * difFactor;
    
    // Specular
    lowp vec3 eye = normalize(positionOut);
    
    lowp vec3 reflection = reflect(light.direction, normal);
    
    lowp float specularFactor = pow(max(0.0, -dot(reflection, eye)), shininess);
    
    lowp vec3 specularColor = light.color * specularIntensity * specularFactor;
    
    gl_FragColor = texture2D(texture, texCoordOut) * vec4(ambColor + difColor + specularColor, 1.0);
    
}

