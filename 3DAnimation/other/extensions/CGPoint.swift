//
//  CGPOint.swift
//  3DAnimation
//
//  Created by GoodDamn on 20/02/2024.
//

import Foundation

extension CGPoint {
    
    mutating func world(
        center: CGPoint
    ) {
        x -= center.x
        y -= center.y
    }
    
    
}
