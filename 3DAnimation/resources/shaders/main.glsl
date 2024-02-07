//
//  main.glsl
//  3DAnimation
//
//  Created by GoodDamn on 06/02/2024.
//

precision mediump float;

varying lowp vec2 texCoordOut;
varying lowp vec3 normalOut;

uniform sampler2D texture;

struct Light {
    lowp vec3 color;
    lowp float ambient;
    lowp float diffIntensity;
    lowp vec3 direction;
};

uniform Light light;

void main() {
    
    lowp vec3 ambColor = light.color * light.ambient;
    
    lowp vec3 normal = normalize(normalOut);
    lowp float difFactor = max(-dot(normal, light.direction), 0.0);
    lowp vec4 difColor = light.color * light.diffIntensity * difFactor;
    
    gl_FragColor = texture2D(texture, texCoordOut) * vec4(ambColor + difColor);
    
}

