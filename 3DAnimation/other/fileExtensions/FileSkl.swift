//
//  FileSkl.swift
//  3DAnimation
//
//  Created by GoodDamn on 20/02/2024.
//

import Foundation

final class FileSkl {
    
    static func write(
        points: inout [CGPoint],
        fileName: String,
        project: CGPoint,
        center: CGPoint
    ) {
        var data = Data()
        
        var count = UInt8(points.count)
        
        data.append(
            &count,
            count: 1
        )
        
        for p in points.indices {
            points[p].world(
                center: center
            )
            
            let a = points[p]
            
            data.append(
                [UInt8(bitPattern: Int8(a.x / project.x)),
                 UInt8(bitPattern: Int8(a.y / project.y)),
                 UInt8(bitPattern: 0)],
                count: 3
            )
            
        }
        
        let fm = FileManager.default
        
        try? data.write(
            to: fm.dirLevels()
                .appendingPathComponent(
                    fileName
                )
        )
    }
    
    
    static func read(
        fileName: String
    ) -> [CGPoint] {
        
        let fm = FileManager.default
        
        let from = fm.dirLevels()
            .appendingPathComponent(
                fileName
            )
        
        guard let data = FileManager
            .default
            .contents(
                atPath: from.path
            ) else {
            return []
        }
        
        let count = data[0]
        
        let countBytes = count * 3
        var i = 1
        
        var points: [CGPoint] = []
        
        while i < countBytes {
            let x = CGFloat(Int8(
                bitPattern: data[i]))
            
            let y = CGFloat(Int8(
                bitPattern: data[i+1]))
            
            let z = data[i+2]
            
            i += 3
            
            points.append(
                CGPoint(
                    x: x,
                    y: y
                )
            )
        }
        
        return points
    }
    
}
