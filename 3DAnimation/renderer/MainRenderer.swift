//
//  MainRenderer.swift
//  3DAnimation
//
//  Created by GoodDamn on 06/01/2024.
//

import Foundation
import GLKit

final class MainRenderer {
    
    private final let TAG = "MainRenderer"
    
    public static var mCamera: BaseCamera!
    public static var mProgram: GLuint = 0
    public var mDelta: Float = 1.0
    
    private var mIsCreated = false
    private var meshes: [Mesh]!
    private var mLights: [BaseLight]!
    
    final func onCreate(
        _ frame: CGRect
    ) {
        
        MainRenderer.mCamera = BaseCamera(
            frame: frame
        )

        guard let program = OpenGL
            .createProgram(
                vertFile: "vert.glsl",
                fragFile: "main.glsl"
            ) else {
            print("ERROR_WHITE_LOADING_PROGRAM")
            return
        }
        
        MainRenderer.mProgram = program
        
        glLinkProgram(MainRenderer
            .mProgram
        )
        
        meshes = [
            Mesh(
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
        
        meshes[0]
            .addScale(3.0)
        
        mLights[0].position(
            x: 0,
            y: -1.5,
            z: -1.5
        )
        
        mLights[0].color(
            r: 1.0,
            g: 1.0,
            b: 1.0
        )
        
        mIsCreated = true
        
        MainRenderer
            .mCamera
            .addPosition(
                x: 0,
                y: 0.0,
                z: -8.0
            )
        
        glEnable(GLenum(GL_DEPTH_TEST))
    }
    
    final func onDraw(
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
        
        meshes.forEach { e in
            e.draw()
        }
        
        mLights.forEach { e in
            e.draw()
        }
    }
    
    final func onUpdate() {
        
        meshes.forEach { it in
            it.onUpdate()
        }
        
    }
    
    var mpoint: CGPoint = .zero
    
    final func onTouchBegan(
        pos: CGPoint
    ) {
        mpoint = pos
    }
    
    var a: Float = 0.0
    var b: Float = 0.0
    final func onTouchMoved(
        pos: CGPoint
    ) {
        let dx = Float(pos.x - mpoint.x) * mDelta
        let dy = Float(mpoint.y - pos.y) * mDelta
        
        a += dx
        b += dy
            
        MainRenderer
            .mCamera
            .addRotationY(
                dx * 2.5
            )
        
        /*MainRenderer
            .mCamera
            .position(
                x: 5.0 * cosf(a),
                y: 5.0 * sinf(b),
                z: 0
            )*/
        
        mpoint = pos
    }
    
    final func onTouchEnded(
        pos: CGPoint
    ) {
        
    }
    
    final func isCreated() -> Bool {
        return mIsCreated
    }
    
}
