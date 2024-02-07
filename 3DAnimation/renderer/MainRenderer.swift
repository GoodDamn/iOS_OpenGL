//
//  MainRenderer.swift
//  3DAnimation
//
//  Created by GoodDamn on 06/01/2024.
//

import Foundation
import GLKit

class MainRenderer {
    
    private final let TAG = "MainRenderer"
    
    private final let mFragmentCode =
    """
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
        lowp vec3 difColor = light.color * light.diffIntensity * difFactor;
        
        gl_FragColor = texture2D(texture, texCoordOut) * vec4(ambColor + difColor, 1.0);
        
    }

    """
    
    private final let mVertexCode =
    """
    attribute vec4 position;
    attribute vec4 color;
    attribute vec2 texCoordIn;
    attribute vec3 normalIn;

    varying lowp vec2 texCoordOut;
    varying lowp vec3 normalOut;

    uniform mat4 projection;
    uniform mat4 model;

    void main() {
        gl_Position = projection * model * position;
        texCoordOut = texCoordIn;
        normalOut = (model * vec4(normalIn, 0.0)).xyz;
    }

    """
    
    public static var mCamera: BaseCamera!
    public static var mProgram: GLuint = 0
    
    private var mIsCreated = false
    private var mEntities: [Entity]!
    private var mLights: [BaseLight]!
    
    func onCreate(
        _ frame: CGRect
    ) {
        
        MainRenderer.mCamera = BaseCamera(
            frame: frame
        )
        
        MainRenderer.mProgram = OpenGL
            .createProgram(
                mVertexCode,
                mFragmentCode
            )
        
        glLinkProgram(MainRenderer
            .mProgram
        )
        
        mEntities = [
            Entity(
                objectName: "box.obj",
                textureName: "box.png",
                program: MainRenderer
                    .mProgram
            )
        ]
        
        mLights = [
            BaseLight(
                program: MainRenderer
                    .mProgram
            )
        ]
        
        
        mIsCreated = true
        
        glEnable(GLenum(GL_DEPTH_TEST))
    }
    
    func onDraw(
        _ frame: CGRect
    ) {
        glClearColor(0.1,0.1,0.1,1.0)
        glClear(
            GLbitfield(
                GL_COLOR_BUFFER_BIT
            ) | GLbitfield(GL_DEPTH_BUFFER_BIT)
        )
        
        glViewport(
            GLint(0),
            GLint(0),
            GLint(frame.width),
            GLint(frame.height)
        )
        
        glUseProgram(
            MainRenderer
                .mProgram
        )
        
        mEntities.forEach { e in
            e.draw()
        }
        
        mLights.forEach { e in
            e.draw()
        }
    }
    
    func onUpdate() {

        MainRenderer
            .mCamera
            .addPosition(
                x: 0,
                y: 0,
                z: -0.01
            )
        
        mEntities.forEach { it in
            it.onUpdate()
        }
        
        /*mLights.forEach { it in
            it.position(
                x: <#T##Float#>,
                y: <#T##Float#>,
                z: <#T##Float#>
            )
        }*/
    }
    
    func isCreated() -> Bool {
        return mIsCreated
    }
    
}
