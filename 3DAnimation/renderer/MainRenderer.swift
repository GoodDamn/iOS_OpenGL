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
    
    private var mIsCreated = false
    
    private var mEntities: [Entity]? = nil
    
    private var mCameraView: GLKMatrix4!
    
    func onCreate(
        _ frame: CGRect
    ) {
        let p = Bundle
            .main
            .resourceURL!
            .appendingPathComponent(
                "Box.obj"
            )
                
        mCameraView = GLKMatrix4MakeTranslation(
            0.0,
            -1.0,
            0.0
        )
        
        mEntities = [
            Entity(
                objectPath: p.path
            )
        ]
        
        mIsCreated = true
    }
    
    func onDraw(
        _ frame: CGRect
    ) {
        glClearColor(0.1,0.1,0.1,1.0)
        glClear(
            GLbitfield(
                GL_COLOR_BUFFER_BIT
            )
        )
        
        glViewport(
            GLint(0),
            GLint(0),
            GLint(frame.width),
            GLint(frame.height))
                
        mEntities!.forEach { e in
            e.draw(
                cameraView: mCameraView
            )
        }
    }
    
    func onUpdate() {
        mEntities?.forEach { it in
            it.onUpdate()
        }
    }
    
    func isCreated() -> Bool {
        return mIsCreated
    }
    
}
