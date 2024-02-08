//
//  Mesh.swift
//  3DAnimation
//
//  Created by GoodDamn on 07/02/2024.
//

import Foundation
import GLKit

final class Mesh
    : Entity {
    
    private final let TAG = "Mesh"
    
    private var mObject: Object3d
    private var mTexture: Texture
    
    private var mPosition: GLuint
    private var mAttrTexCoord: GLuint
    private var mAttrNormal: GLuint
    
    private var modelViewUniform: GLint = 1
    private var mProjectUniform: GLint = 1
    
    private var mVertexBuffer: GLuint = 1
    private var mIndexBuffer: GLuint = 1
    
    private var mVertexArrayObject: GLuint = 1
    
    //private let light: BaseLight
    
    init(
        objectName: String,
        textureName: String,
        program: GLuint
    ) {
        mObject = Loader.obj(
            assetName: objectName
        )!
        
        /*light = BaseLight(
            program: program
        )*/
        
        mTexture = Texture(
            assetName: textureName
        )
        
        mTexture.setup(
            program: program
        )
        
        modelViewUniform = glGetUniformLocation(
            program,
            "model"
        )
        
        mProjectUniform = glGetUniformLocation(
            program,
            "projection"
        )
        
        let stride = GLsizei(8 * 4)
        
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
        
        mAttrTexCoord = GLuint(
            glGetAttribLocation(
                program,
                "texCoordIn")
        )
        
        mAttrNormal = GLuint(
            glGetAttribLocation(
                program,
                "normalIn"
            )
        )
        
        mPosition = GLuint(
            glGetAttribLocation(
                program,
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
            stride, // stride
            nil
        )
        
        
        glEnableVertexAttribArray(
            mAttrTexCoord
        )
        
        glVertexAttribPointer(
            mAttrTexCoord,
            GLint(2),
            GLenum(GL_FLOAT),
            GLboolean(GL_FALSE),
            stride,
            UnsafeRawPointer(bitPattern: 3 * 4)
        )
        
        glEnableVertexAttribArray(
            mAttrNormal
        )
        
        glVertexAttribPointer(
            mAttrNormal,
            GLint(3),
            GLenum(GL_FLOAT),
            GLboolean(GL_FALSE),
            GLsizei(8 * 4),
            UnsafeRawPointer(bitPattern: 5 * 4)
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
        
        super.init()
        
    }
    
    func onUpdate() {
        
    }
    
    func draw() {
        
        MainRenderer
            .mCamera
            .lay(
                projUnif: mProjectUniform,
                modelUnif: modelViewUniform,
                model: &model
            )
        
        glBindVertexArrayOES(
            mVertexArrayObject
        )
        
        glDrawElements(
            GLenum(GL_TRIANGLES),
            GLsizei(mObject.indices.count),
            GLenum(GL_UNSIGNED_SHORT),
            nil
        )
        
        mTexture.draw()
        
        glBindVertexArrayOES(
            0
        )
        
    }
}
