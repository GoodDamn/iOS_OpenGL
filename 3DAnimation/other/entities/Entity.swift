//
//  Entity.swift
//  3DAnimation
//
//  Created by GoodDamn on 05/01/2024.
//

import Foundation
import GLKit

class Entity {
   
    internal var model = GLKMatrix4Identity
    
    private var mRotationX: CGFloat = 0
    private var mRotationY: CGFloat = 0
    private var mRotationZ: CGFloat = 0
    
    public final func position(
        x: Float,
        y: Float,
        z: Float
    ) {
        model = GLKMatrix4MakeTranslation(
            x,
            y,
            z
        )
    }
    
    public final func addPosition(
        x: Float,
        y: Float,
        z: Float
    ) {
        model = GLKMatrix4Translate(
            model,
            x,
            y,
            z
        )
    }
    
    public final func addRotationX(
        _ deg: Float
    ) {
        model = GLKMatrix4RotateX(
            model,
            GLKMathDegreesToRadians(deg)
        )
    }
    
    public final func addRotationY(
        _ deg: Float
    ) {
        model = GLKMatrix4RotateY(
            model,
            GLKMathDegreesToRadians(deg)
        )
    }
    
    public final func addRotationZ(
        _ deg: Float
    ) {
        
        model = GLKMatrix4RotateZ(
            model,
            GLKMathDegreesToRadians(deg)
        )
    }
    
    public final func addScale(
        _ val: Float
    ) {
        
        model = GLKMatrix4Scale(
            model,
            val,
            val,
            val
        )
        
    }
    
}

extension GLKMatrix4 {
    var array: [Float] {
        return (0..<16).map { i in
            self[i]
        }
    }
    
}
