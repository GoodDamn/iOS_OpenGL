//
//  BaseLight.swift
//  3DAnimation
//
//  Created by GoodDamn on 06/02/2024.
//

import Foundation
import GLKit

class BaseLight {
    
    private var mLightColorUniform: GLint = 1
    private var mLightAmbientUniform: GLint = 1
    private var mLightDirectionUniform: GLint = 1
    private var mLightIntensityUniform: GLint = 1
    
    private var mDirection = GLKVector3()
    private var mColor = GLKVector3()
    
    init(
        program: GLuint
    ) {
        mLightColorUniform = glGetUniformLocation(
            program,
            "light.color"
        )
        
        mLightAmbientUniform = glGetUniformLocation(
            program,
            "light.ambient"
        )
        
        mLightDirectionUniform = glGetUniformLocation(
            program,
            "light.direction"
        )
        
        mLightIntensityUniform = glGetUniformLocation(
            program,
            "light.diffIntensity"
        )
    }
    
    public final func position(
        x: Float,
        y: Float,
        z: Float
    ) {
        
        mDirection = GLKVector3Normalize(
            GLKVector3Make(
                x,
                y,
                z
            )
        )
        
    }
    
    public final func color(
        r: Float,
        g: Float,
        b: Float
    ) {
        mColor.r = r
        mColor.g = g
        mColor.b = b
    }
    
    public final func draw() {
        glUniform3f(
            mLightColorUniform,
            mColor.r,
            mColor.g,
            mColor.b
        )
        
        
        glUniform1f(
            mLightAmbientUniform,
            GLfloat(0.1)
        )
        
        glUniform3f(
            mLightDirectionUniform,
            mDirection.x,
            mDirection.y,
            mDirection.z
        )
        
        glUniform1f(
            mLightIntensityUniform,
            GLfloat(0.8)
        )
    }
}
