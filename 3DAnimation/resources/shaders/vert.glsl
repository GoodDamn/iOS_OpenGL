//
//  frag.glsl
//  3DAnimation
//
//  Created by GoodDamn on 06/02/2024.
//

attribute vec4 position;
attribute vec4 color;
attribute vec2 texCoordIn;
attribute vec3 normalIn;

varying lowp vec2 texCoordOut;
varying lowp vec3 normalOut;
varying lowp vec3 positionOut;

uniform mat4 projection;
uniform mat4 model;

void main() {
    gl_Position = projection * model * position;
    texCoordOut = texCoordIn;
    normalOut = (model * vec4(normalIn, 0.0)).xyz;
    positionOut = (model * position).xyz;
}
