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
    
    private var mProjection: GLKMatrix4!
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
            -1.0,
            -1.0,
            -5.0
        )
        
        mProjection = GLKMatrix4MakePerspective(
            85.0 / 180 * .pi,
            Float(frame.width / frame.height),
            1,
            150
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
                
        let proj = mProjection.array
        
        mEntities!.forEach { e in
            e.draw(
                cameraView: mCameraView,
                projection: proj
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
