//
//  BaseCamera.swift
//  3DAnimation
//
//  Created by GoodDamn on 06/02/2024.
//

import Foundation
import GLKit.GLKMatrix4

class BaseCamera {
    
    private var modelCamera: GLKMatrix4
    private var mProjection: GLKMatrix4
    
    init(
        frame: CGRect
    ) {
        modelCamera = GLKMatrix4MakeTranslation(
            0.0,
            0.0,
            0.0
        )
        
        mProjection = GLKMatrix4MakePerspective(
            85.0 / 180 * .pi,
            Float(frame.width / frame.height),
            1,
            150
        )
    }
    
    public final func addPosition(
        x: Float,
        y: Float,
        z: Float
    ) {
        modelCamera = GLKMatrix4Translate(
            modelCamera,
            x,
            y,
            z
        )
    }
    
    public final func lay(
        projUnif: GLint,
        modelUnif: GLint,
        model: inout GLKMatrix4
    ) {
        glUniformMatrix4fv(
            projUnif,
            GLsizei(1),
            GLboolean(0),
            MainRenderer
                .mCamera
                .proj()
                .array
        )
        
        glUniformMatrix4fv(
            modelUnif,
            GLsizei(1),
            GLboolean(0),
            GLKMatrix4Multiply(
                modelCamera,
                model
            ).array
        )
    }
    
    public final func view() -> GLKMatrix4 {
        return modelCamera
    }
    
    public final func proj() -> GLKMatrix4 {
        return mProjection
    }
    
}
