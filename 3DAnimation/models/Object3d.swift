//
//  Object3d.swift
//  3DAnimation
//
//  Created by GoodDamn on 06/01/2024.
//

import Foundation
import GLKit

struct Object3d {
    let vertices: [GLfloat]
    let normals: [GLfloat]
    let texCoords: [GLfloat]
    let indices: [GLshort]
}
