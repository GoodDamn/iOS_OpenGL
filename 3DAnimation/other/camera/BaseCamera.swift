//
//  BaseCamera.swift
//  3DAnimation
//
//  Created by GoodDamn on 06/02/2024.
//

import Foundation
import GLKit.GLKMatrix4

final class BaseCamera
    : Entity {
    
    private var mProjection: GLKMatrix4
    
    private var mDirection: GLKVector3
    
    init(
        frame: CGRect
    ) {
        mProjection = GLKMatrix4MakePerspective(
            85.0 / 180 * .pi,
            Float(frame.width / frame.height),
            1,
            150
        )
        
        mDirection = GLKVector3Make(
            0,
            0,
            0
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
                self.model,
                model
            ).array
        )
    }
    
    public final func view() -> GLKMatrix4 {
        return model
    }
    
    public final func proj() -> GLKMatrix4 {
        return mProjection
    }
    
    
    public final func addRotation(
        y: Float,
        z: Float
    ) {
        
        
    }
    
}
