//
//  Entity.swift
//  3DAnimation
//
//  Created by GoodDamn on 05/01/2024.
//

import Foundation
import GLKit

class Entity {
    
    private final let mFragmentCode =
    """
    precision mediump float;
    void main() {
        gl_FragColor = vec4(1.0,0.0,0.0,1.0);
    }
    """
    
    private final let mVertexCode =
    """
    attribute vec4 position;
    void main() {
        gl_Position = position;
    }
    """
    
    private var mObject: Object3d
    
    private var mPosition: GLuint
    
    private var mProgram: GLuint
    
    init(
        objectPath: String
    ) {
        
        let fm = FileManager.default
        
        let data = fm.contents(
            atPath: objectPath
        )!
        
        mObject = Loader.obj(
            data: data
        )!
        
        
        mProgram = glCreateProgram()
        
        glAttachShader(
            mProgram,
            OpenGL.loadShader(
                GL_VERTEX_SHADER,
                mVertexCode
            )
        )
        
        glAttachShader(
            mProgram,
            OpenGL.loadShader(
                GL_FRAGMENT_SHADER,
                mFragmentCode
            )
        )
        
        glLinkProgram(mProgram)
        
        print("asdasdsadasd",mProgram)
        
        mPosition = GLuint(
            glGetAttribLocation(
                mProgram,
                "position"
            )
        )
        
    }
    
    
    func draw() {
        
        glUseProgram(mProgram)

        glVertexAttribPointer(
            mPosition,
            GLint(3),
            GLenum(GL_FLOAT),
            GLboolean(GL_FALSE),
            GLsizei(0),
            mObject.vertices
        )
        
        glEnableVertexAttribArray(
            mPosition
        )
        
        glDrawElements(
            GLenum(GL_TRIANGLES),
            GLsizei(mObject.indices.count),
            GLenum(GL_UNSIGNED_SHORT),
            mObject.indices
        )
        
    }
    
}
