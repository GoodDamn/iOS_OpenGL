//
//  Matrix.swift
//  3DAnimation
//
//  Created by GoodDamn on 06/01/2024.
//

import Foundation

public class Matrix {
    
    public static func identity(
        _ matrix: [Float]
    ) -> [Float] {
        
        var matrix = matrix
        
        matrix[0] = 1.0
        matrix[1] = 0.0
        matrix[2] = 0.0
        matrix[3] = 0.0
        matrix[4] = 0.0
        matrix[5] = 1.0
        matrix[6] = 0.0
        matrix[7] = 0.0
        matrix[8] = 0.0
        matrix[9] = 0.0
        matrix[10] = 1.0
        matrix[11] = 0.0
        matrix[12] = 0.0
        matrix[13] = 0.0
        matrix[14] = 0.0
        matrix[15] = 1.0
        
        return matrix
    }
    
    public static func translate(
        _ matrix:[Float]?,
        _ x: Float,
        _ y: Float,
        _ z: Float
    ) {
    }
    
    public static func mult(
        _ dest: [Float],
        _ f: [Float],
        _ f1: [Float]
    ) -> [Float] {
        
        var dest = dest
        
        var res = ([Float])(
            repeating: 0,
            count: 16
        )
        
        var row = 0
        var column = 0
        
        for i in 0..<4 {
            let a = 4 * i
            for j in 0..<4 {
                res[a + j] =
                    f[j] * f1[a] +
                    f[4+j] * f1[a+1] +
                    f[8+j] * f1[a+2] +
                    f[12+j] * f1[a + 3]
            }
        }
        
        for i in 0..<16 {
            dest[i] = res[i]
        }
        
        return dest
    }
    
    public static func perspect(
        _ matrix: [Float],
        _ fov: Float,
        _ aspect: Float,
        _ zNear: Float,
        _ zFar: Float
    ) -> [Float]{
        
        var ymax = zNear * tanf(fov * .pi / 360.0)
        var xmax = ymax * aspect
        
        return frustum(
            matrix,
            -xmax,
            xmax,
            -ymax,
            ymax,
            zNear,
            zFar
        )
    }
    
    public static func frustum(
        _ matrix: [Float],
        _ left: Float,
        _ right: Float,
        _ bottom: Float,
        _ top: Float,
        _ zNear: Float,
        _ zFar: Float
    ) -> [Float] {
        var matrix = matrix
        
        let temp = 2.0 * zNear
        
        let xd = right - left
        let yd = top - bottom
        let zd = zFar - zNear
        identity(matrix)
        matrix[0] = temp / xd
        matrix[5] = temp / yd
        matrix[8] = (right + left) / xd
        matrix[9] = (top + bottom) / yd
        matrix[10] = (-zFar - zNear) / zd
        matrix[11] = -1.0
        matrix[14] = (-temp * zFar) / zd
        matrix[15] = 0.0
        
        print("Matrix:",matrix)
        return matrix
    }
    
}
