//
//  main.glsl
//  3DAnimation
//
//  Created by GoodDamn on 06/02/2024.
//

precision mediump float;

varying lowp vec2 texCoordOut;
uniform sampler2D texture;

struct Light {
    lowp vec3 color;
    lowp float ambient;
};

uniform Light light;

void main() {
    
    lowp vec4 ambColor = vec4(light.color, 1.0) * light.ambient;
    
    gl_FragColor = texture2D(texture, texCoordOut) * ambColor;
    
}

