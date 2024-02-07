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
    varying lowp vec3 normalOut;

    uniform sampler2D texture;

    struct Light {
        lowp vec3 color;
        lowp float ambient;
        lowp float diffIntensity;
        lowp vec3 direction;
    };

    uniform Light light;

    void main() {
        
        lowp vec3 ambColor = light.color * light.ambient;
        
        lowp vec3 normal = normalize(normalOut);
        lowp float difFactor = max(-dot(normal, light.direction), 0.0);
        lowp vec3 difColor = light.color * light.diffIntensity * difFactor;
        
        gl_FragColor = texture2D(texture, texCoordOut) * vec4(ambColor + difColor, 1.0);
        
    }

    """
    
    private final let mVertexCode =
    """
    attribute vec4 position;
    attribute vec4 color;
    attribute vec2 texCoordIn;
    attribute vec3 normalIn;

    varying lowp vec2 texCoordOut;
    varying lowp vec3 normalOut;

    uniform mat4 projection;
    uniform mat4 model;

    void main() {
        gl_Position = projection * model * position;
        texCoordOut = texCoordIn;
        normalOut = (model * vec4(normalIn, 0.0)).xyz;
    }

    """
    
    private var mObject: Object3d
    private var mTexture: Texture
    
    private var modelView = GLKMatrix4Identity
    
    private var mPosition: GLuint
    private var mAttrTexCoord: GLuint
    private var mAttrNormal: GLuint
    
    private var mTextureUniform: GLint = 1
    private var mLightColorUniform: GLint = 1
    private var mLightAmbientUniform: GLint = 1
    private var mLightDirectionUniform: GLint = 1
    private var mLightIntensityUniform: GLint = 1
    
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
        
        mLightColorUniform = glGetUniformLocation(
            mProgram,
            "light.color"
        )
        
        mLightAmbientUniform = glGetUniformLocation(
            mProgram,
            "light.ambient"
        )
        
        mLightDirectionUniform = glGetUniformLocation(
            mProgram,
            "light.direction"
        )
        
        mLightIntensityUniform = glGetUniformLocation(
            mProgram,
            "light.diffIntensity"
        )
        
        modelViewUniform = glGetUniformLocation(
            mProgram,
            "model"
        )
        
        mProjectUniform = glGetUniformLocation(
            mProgram,
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
                mProgram,
                "texCoordIn")
        )
        
        mAttrNormal = GLuint(
            glGetAttribLocation(
                mProgram,
                "normalIn"
            )
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
            0.03,
            0,
            0
        )
        
        modelView = GLKMatrix4Rotate(
            modelView,
            GLKMathDegreesToRadians(
                1
            ),
            0.0,
            1.0,
            0.0
        )
        
    }
    
    func draw() {
        glUseProgram(mProgram)
        
        MainRenderer
            .mCamera
            .lay(
                projUnif: mProjectUniform,
                modelUnif: modelViewUniform,
                model: &modelView
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
        
        mTexture.draw(
            uniform: mTextureUniform
        )
        
        glUniform3f(
            mLightColorUniform,
            GLfloat(1.0),
            GLfloat(1.0),
            GLfloat(1.0)
        )
        
        
        glUniform1f(
            mLightAmbientUniform,
            GLfloat(0.1)
        )
        
        let normDirect = GLKVector3Normalize(
            GLKVector3Make(0, 1, -1)
        )
        
        glUniform3f(
            mLightDirectionUniform,
            normDirect.x,
            normDirect.y,
            normDirect.z
        )
        
        glUniform1f(
            mLightIntensityUniform,
            GLfloat(0.5)
        )
        
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
