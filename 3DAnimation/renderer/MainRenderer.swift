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
    
    public static var mCamera: BaseCamera!
    
    private var mIsCreated = false
    
    private var mEntities: [Entity]? = nil
    
    func onCreate(
        _ frame: CGRect
    ) {
        
        MainRenderer.mCamera = BaseCamera(
            frame: frame
        )
        
        mEntities = [
            Entity(
                objectName: "box.obj",
                textureName: "box.png"
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
        
        mEntities!.forEach { e in
            e.draw()
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
