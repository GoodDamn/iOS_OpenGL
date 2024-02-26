//
//  RotationCamera.swift
//  3DAnimation
//
//  Created by GoodDamn on 26/02/2024.
//

import Foundation
import GLKit.GLKMath

final class RotationCamera
    : BaseCamera {
    
    private var mRadius: Float = 10.0
    
    private var mHDeg: Float = 40
    private var mVDeg: Float = 40
    
    public final func rotate(
        hDegrees: Float,
        vDegrees: Float
    ) {
        
        mHDeg += hDegrees
        mVDeg += vDegrees
        
        let hrad = GLKMathDegreesToRadians(
            mHDeg
        )
        
        let vrad = GLKMathDegreesToRadians(
            mVDeg
        )
        
        let ysin = sinf(vrad)
        
        mPosition.x = mRadius * cosf(hrad) * ysin
        mPosition.y = mRadius * cosf(vrad)
        mPosition.z = mRadius * ysin * sinf(hrad)
        
        model = GLKMatrix4MakeLookAt(
            mPosition.x, mPosition.y, mPosition.z, // Position
            0, 0, 0, // AT vector
            0, 1, 0 // UP vector
        )
        
    }
    
}
