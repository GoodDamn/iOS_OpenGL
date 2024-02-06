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
    
    varying lowp vec2 texCoordOut;
    uniform sampler2D texture;
    
    void main() {
        gl_FragColor = texture2D(texture, texCoordOut);
    }
    """
    
    private final let mVertexCode =
    """
    attribute vec4 position;
    attribute vec4 color;
    
    attribute vec2 texCoordIn;
    varying lowp vec2 texCoordOut;
    
    uniform mat4 projection;
    uniform mat4 model;
    
    void main() {
        gl_Position = projection * model * position;
        texCoordOut = texCoordIn;
    }
    """
    
    private var mObject: Object3d
    private var mTexture: Texture
    
    private var modelView = GLKMatrix4Identity
    
    private var mPosition: GLuint
    
    private var mAttrTexCoord: GLuint
    
    private var mTextureUniform: GLint = 1
    
    private var modelViewUniform: GLint = 1
    private var mProjectUniform: GLint = 1
    
    private var mVertexBuffer: GLuint = 1
    private var mIndexBuffer: GLuint = 1
    
    private var mVertexArrayObject: GLuint = 1
    
    private var mProgram: GLuint
    
    init(
        objectName: String,
        textureName: String
    ) {
        
        mObject = Loader.obj(
            assetName: objectName
        )!
        
        mTexture = Texture(
            assetName: textureName
        )
        
        mProgram = OpenGL
            .createProgram(
                mVertexCode,
                mFragmentCode
            )
        
        glLinkProgram(mProgram)
        
        mTextureUniform = glGetUniformLocation(
            mProgram,
            "texture"
        )
        
        modelViewUniform = glGetUniformLocation(
            mProgram,
            "model"
        )
        
        mProjectUniform = glGetUniformLocation(
            mProgram,
            "projection"
        )
        
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
                mProgram,
                "texCoordIn")
        )
        
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
            GLsizei(5 * 4), // stride
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
            GLsizei(5 * 4),
            UnsafeRawPointer(bitPattern: 3 * 4)
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
        
        
        modelView = GLKMatrix4Translate(
            modelView,
            -0.5,
            -0.5,
            0
        )
        
    }
    
    func onUpdate() {
        modelView = GLKMatrix4Translate(
            modelView,
            0.01,
            0,
            0
        )
        
    }
    
    func draw(
        cameraView: GLKMatrix4,
        projection: [Float]
    ) {
        glUseProgram(mProgram)
        
        glUniformMatrix4fv(
            mProjectUniform,
            GLsizei(1),
            GLboolean(0),
            projection)
        
        glUniformMatrix4fv(
            modelViewUniform,
            GLsizei(1),
            GLboolean(0),
            GLKMatrix4Multiply(
                cameraView,
                modelView).array
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
        
        glActiveTexture(
            GLenum(GL_TEXTURE_2D)
        )
        
        glBindTexture(
            GLenum(GL_TEXTURE_2D),
            mTexture.texId
        )
        
        glUniform1i(
            mTextureUniform,
            0)
        
        glBindVertexArrayOES(
            0
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
