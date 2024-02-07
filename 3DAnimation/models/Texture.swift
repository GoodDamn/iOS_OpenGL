//
//  Texture.swift
//  3DAnimation
//
//  Created by GoodDamn on 07/01/2024.
//

import Foundation
import GLKit

final class Texture {
    
    private final var mId: GLuint = 0
    private final var mTextureUniform: GLint = 1
    
    init(
        assetName: String
    ) {
        let fm = FileManager.default
        
        let url = Bundle.main.resourceURL!.appendingPathComponent(assetName)
        let data = fm.contents(
            atPath: url.path
        )!
        
        loadTexture(data)
    }
    
    init(
        data: Data
    ) {
        loadTexture(data)
    }
 
    public final func setup(
        program: GLuint
    ) {
        mTextureUniform = glGetUniformLocation(
            program,
            "texture"
        )
        
    }
    
    public final func draw() {
        
        glActiveTexture(
            GLenum(GL_TEXTURE_2D)
        )
        
        glBindTexture(
            GLenum(GL_TEXTURE_2D),
            mId
        )
        
        glUniform1i(
            mTextureUniform,
            0
        )
    }
    
    private final func loadTexture(
        _ data: Data
    ) {
        guard let image = UIImage(
            data: data
        )?.cgImage else {
            return
        }
        
        let width = image.width
        let height = image.height
        
        let spriteData = calloc(
            width * height * 4,
            1
        )
        
        let spriteContext = CGContext(
            data: spriteData,
            width: width,
            height: height,
            bitsPerComponent: 8,
            bytesPerRow: width * 4,
            space: image.colorSpace!,
            bitmapInfo: CGImageAlphaInfo
                .premultipliedLast
                .rawValue
        )
        
        spriteContext!.draw(
            image,
            in: CGRect(
                x: 0,
                y: 0,
                width: width,
                height: height
            )
        )
        
        // Auto memory management CGContextRelease
        
        glGenTextures(
            GLsizei(1),
            &mId
        )
        
        let t = GLenum(GL_TEXTURE_2D)
        
        glBindTexture(
            t,
            mId
        )
        
        glTexParameteri(
            t,
            GLenum(GL_TEXTURE_MIN_FILTER),
            GLint(GL_NEAREST)
        )
        
        glTexParameteri(
            t,
            GLenum(GL_TEXTURE_MAG_FILTER),
            GL_LINEAR
        )
        
        glTexParameteri(
            t,
            GLenum(GL_TEXTURE_WRAP_S),
            GL_CLAMP_TO_EDGE
        )
        
        glTexParameteri(
            t,
            GLenum(GL_TEXTURE_WRAP_T),
            GL_CLAMP_TO_EDGE
        )
        
        glTexImage2D(
            GLenum(GL_TEXTURE_2D),
            0,
            GL_RGBA,
            GLsizei(width),
            GLsizei(height),
            0,
            GLenum(GL_RGBA),
            GLenum(GL_UNSIGNED_BYTE),
            spriteData!
        )
        
        free(spriteData)
    }
    
}
