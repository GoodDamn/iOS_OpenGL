//
//  OpenGL.swift
//  3DAnimation
//
//  Created by GoodDamn on 05/01/2024.
//

import Foundation
import GLKit

public class OpenGL {
    
    public static let TAG = "OpenGL"
    
    public static func loadShader(
        _ type: Int32,
        _ code: String
    ) -> GLuint{
        
        let shader = glCreateShader(
            GLenum(type)
        )
        
        print(TAG, "loadShader:", shader)
        
        var cString = (code as NSString).utf8String
        
        glShaderSource(
            shader,
            GLsizei(1),
            &cString,
            nil
        )
        
        glCompileShader(shader)
        
        return shader
    }
    
}
