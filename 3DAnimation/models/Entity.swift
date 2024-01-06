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
        gl_FragColor = vec4(1.0,1.0,1.0,1.0);
    }
    """
    
    private final let mVertexCode =
    """
    attribute vec4 position;
    attribute vec3 color;
    uniform mat4 proj;
    uniform mat4 model;
    void main() {
        gl_Position = proj * model * position;
    }
    """
    
    private var mObject: Object3d
    
    private var mProjection: [Float]
    private var modelViewMatrix: [Float]
    
    private var mPosition: GLuint
    private var mProj: GLuint
    private var modelView: GLuint
    
    private var mProgram: GLuint
    
    init(
        objectPath: String,
        projection: [Float]
    ) {
       
        mProjection = projection
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
        
        mPosition = GLuint(
            glGetAttribLocation(
                mProgram,
                "position"
            )
        )
        
        mProj = GLuint(
            glGetUniformLocation(
                mProgram,
                "proj"
            )
        )
        
        modelView = GLuint(
            glGetUniformLocation(
                mProgram,
                "model"
            )
        )
        modelViewMatrix = ([Float])(
            repeating: 0,
            count: 16
        )
        print(TAG, mProjection)
        modelViewMatrix = Matrix
            .identity(
                modelViewMatrix
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
        
        glUniformMatrix4fv(
            GLint(mProj),
            GLsizei(1),
            GLboolean(GL_FALSE),
            mProjection
        )
        
        glUniformMatrix4fv(
            GLint(modelView),
            GLsizei(1),
            GLboolean(GL_FALSE),
            modelViewMatrix
        )
        
        glDrawElements(
            GLenum(GL_TRIANGLES),
            GLsizei(mObject.indices.count),
            GLenum(GL_UNSIGNED_SHORT),
            mObject.indices
        )
        
    }
    
}
