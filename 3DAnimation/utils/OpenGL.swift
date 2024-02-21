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
    
    public static func createProgram(
        vertFile: String,
        fragFile: String
    ) -> GLuint? {
        
        guard let vertexCode = FileManager
            .readBundleString(
                fileName: vertFile
            ) else {
            print("ERROR_WHILE_READING_VERT_FILE")
            return nil
        }
        
        guard let fragCode = FileManager
            .readBundleString(
                fileName: fragFile
            ) else {
            print("ERROR_WHILE_READING_FRAG_FILE")
            return nil
        }
        
        let mProgram = glCreateProgram()
        
        glAttachShader(
            mProgram,
            OpenGL.loadShader(
                GL_VERTEX_SHADER,
                vertexCode
            )
        )
        
        glAttachShader(
            mProgram,
            OpenGL.loadShader(
                GL_FRAGMENT_SHADER,
                fragCode
            )
        )
        
        return mProgram
    }
    
}
