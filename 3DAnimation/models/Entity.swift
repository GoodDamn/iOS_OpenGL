//
//  Entity.swift
//  3DAnimation
//
//  Created by GoodDamn on 05/01/2024.
//

import Foundation
import GLKit

class Entity {
    
    private final let TAG = "Entity"
    
    private final let mFragmentCode =
    """
    precision mediump float;
    void main() {
        float a = gl_FragCoord.x / 1179.0;
        gl_FragColor = vec4(1.0-a,a,0.0,1.0);
    }
    """
    
    private final let mVertexCode =
    """
    attribute vec4 position;
    attribute vec4 color;
    
    void main() {
        gl_Position = position;
    }
    """
    
    private var mObject: Object3d
    
    private var mPosition: GLuint
    
    private var mVertexBuffer: GLuint = 1
    private var mIndexBuffer: GLuint = 1
    
    private var mVertexArrayObject: GLuint = 1
    
    private var mProgram: GLuint
    
    init(
        objectPath: String
    ) {
        
        let fm = FileManager.default
        
        let data = fm.contents(
            atPath: objectPath
        )!
        
        /*mObject = Loader.obj(
            data: data
        )!*/
        
        mObject = Object3d(
            vertices: [
                1.0, -1.0, 0.0, // right bottom
                0.5, 0.5, 0.0, // right top
                -1.0, 1.0, 0.0, // left top
                -1.0, -1.0, 0.0 // left bottom
           ],
           indices: [
              0,1,2,
              2,3,0
           ]
        )
        
        mProgram = OpenGL
            .createProgram(
                mVertexCode,
                mFragmentCode
            )
        
        glLinkProgram(mProgram)
        
        // Generate VAO and bind a content to it
        glGenVertexArraysOES(
            1,
            &mVertexArrayObject
        )
        
        glBindVertexArrayOES(
            mVertexArrayObject
        )
        
        
        // Generate vertex buffer
        glGenBuffers(
            1,
            &mVertexBuffer
        )
        
        glBindBuffer(
            GLenum(GL_ARRAY_BUFFER),
            mVertexBuffer
        )
        
        glBufferData(
            GLenum(GL_ARRAY_BUFFER),
            GLsizeiptr(mObject
                .vertices
                .count * 4),
            mObject.vertices,
            GLenum(GL_STATIC_DRAW))
        
        mPosition = GLuint(
            glGetAttribLocation(
                mProgram,
                "position"
            )
        )
        
        // Generate index buffer
        
        glGenBuffers(
            GLsizei(1),
            &mIndexBuffer
        )
        
        glBindBuffer(
            GLenum(GL_ELEMENT_ARRAY_BUFFER),
            mIndexBuffer
        )
        
        glBufferData(
            GLenum(GL_ELEMENT_ARRAY_BUFFER),
            GLsizeiptr(mObject.indices.count * 2),
            mObject.indices,
            GLenum(GL_STATIC_DRAW)
        )
        
        // Enable vertex attributes
        
        glEnableVertexAttribArray(
            mPosition
        )
        
        glVertexAttribPointer(
            mPosition,
            GLint(3), // size
            GLenum(GL_FLOAT),
            GLboolean(GL_FALSE),
            GLsizei(3 * 4), // size * sizeof(type)
            nil
        )
        
        glBindVertexArrayOES(
            0
        )
        
        glBindBuffer(
            GLenum(GL_ARRAY_BUFFER),
            0
        )
        
        glBindBuffer(
            GLenum(GL_ELEMENT_ARRAY_BUFFER),
            0
        )
        
    }
        
    func draw() {
        
        glUseProgram(mProgram)
        
        
        glBindVertexArrayOES(
            mVertexArrayObject
        )
        
        glDrawElements(
            GLenum(GL_TRIANGLES),
            GLsizei(mObject.indices.count),
            GLenum(GL_UNSIGNED_SHORT),
            nil
        )
        
        glBindVertexArrayOES(
            0
        )
        
    }
    
}
