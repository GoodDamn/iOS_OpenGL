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
    
    private var mProjection = ([Float])(
        repeating: 0,
        count: 16
    )
    
    func onCreate(
        _ frame: CGRect
    ) {
        let p = Bundle
            .main
            .resourceURL!
            .appendingPathComponent(
                "Box.obj"
            )
        
        mProjection = Matrix
            .perspect(
                mProjection,
                45,
                Float(frame.width / frame.height),
                0.1,
                100
            )
        
        print(TAG, mProjection)
        
        mEntities = [
            Entity(
                objectPath: p.path,
                projection: mProjection
            )
        ]
        
        /*glEnable(
            GLenum(
                GL_DEPTH_TEST
            )
        )*/
        
        glMatrixMode(
            GLenum(GL_MODELVIEW)
        )
        
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
            GLsizei(frame.width),
            GLsizei(frame.height)
        )
        
        mEntities!.forEach { e in
            e.draw()
        }
    }
    
    func onUpdate() {
        
    }
    
    func isCreated() -> Bool {
        return mIsCreated
    }
    
}
