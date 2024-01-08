//
//  File.swift
//  3DAnimation
//
//  Created by GoodDamn on 06/01/2024.
//

import Foundation
import GLKit

class Loader {
    
    private static let TAG = "Loader:"
    
    public static func obj(
        assetName: String
    ) -> Object3d? {
        
        let fm = FileManager.default
        
        let url = Bundle.main.resourceURL!
            .appendingPathComponent(assetName)
        
        let data = fm.contents(
            atPath: url.path
        )!
        
        return loadObj(data)
    }
    
    public static func obj(
        data: Data
    ) -> Object3d? {
        return loadObj(data)
    }
    
    private static func loadObj(
        _ data: Data
    ) -> Object3d? {
        
        guard let d = String(
            data: data,
            encoding: .utf8
        ) else {
            return nil
        }
        
        let lines = d
            .components(
                separatedBy: .newlines
            )
        
        var vert:[Float] = []
        var faces:[String] = []
        var textures:[Float] = []
        var normals:[Float] = []
        
        var indices:[GLshort] = []
        
        lines.forEach {
            it in
            let c = it.components(
                separatedBy: .whitespaces
            )
            switch (c[0]) {
            case "v":
                vert.append(
                    Float(c[1])!
                )
                vert.append(
                    Float(c[2])!
                )
                vert.append(
                    Float(c[3])!
                )
                break
            case "vn":
                normals.append(
                    Float(c[1])!
                )
                normals.append(
                    Float(c[2])!
                )
                normals.append(
                    Float(c[3])!
                )
                break
            case "vt":
                textures.append(
                    Float(c[1])!
                )
                textures.append(
                    Float(c[2])!
                )
                break
            case "f":
                faces.append(c[1])
                faces.append(c[2])
                faces.append(c[3])
                break
            default:
                break
            }
            
        }
        
        var normalss:[GLfloat] = []
        var vertices:[GLfloat] = []
        //var texCoords:[GLfloat] = []
        
        for j in 0..<faces.count {
            indices.append(GLshort(UInt16(j)))
            let parts = faces[j]
                .components(
                    separatedBy: "/"
                )
            
            let vertexIndex = Int(parts[0])! - 1
            
            var i = 3 * vertexIndex
            
            vertices.append(
                GLfloat(
                    vert[i]
                )
            )
            i+=1
            vertices.append(
                GLfloat(
                    vert[i]
                )
            )
            i+=1
            vertices.append(
                GLfloat(
                    vert[i]
                )
            )
            
            // Texture coords
            i = 2 * (Int(parts[1])! - 1)
            vertices.append(
                GLfloat(
                    textures[i]
                )
            )
            i += 1
            vertices.append(
                GLfloat(
                    textures[i]
                )
            )
            
            i = 3 * (Int(parts[2])! - 1)
            normalss.append(
                GLfloat(
                    normals[i]
                )
            )
            i += 1
            normalss.append(
                GLfloat(
                    normals[i]
                )
            )
            i += 1
            normalss.append(
                GLfloat(
                    normals[i]
                )
            )
        }
        
        return Object3d(
            vertices: vertices,
            normals: normalss,
            indices: indices
        )
        
    }
    
}
