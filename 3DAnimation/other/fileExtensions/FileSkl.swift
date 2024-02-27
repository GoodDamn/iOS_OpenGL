//
//  FileSkl.swift
//  3DAnimation
//
//  Created by GoodDamn on 20/02/2024.
//

import Foundation

final class FileSkl {
    
    static func write(
        entities: inout [EditorEntity],
        fileName: String,
        project: CGPoint,
        center: CGPoint
    ) {
        var data = Data()
        
        var count = UInt8(entities.count)
        
        data.append(
            &count,
            count: 1
        )
        
        let zeroData = Data(
            capacity: 1
        )
        
        for i in entities.indices {
            
            var entity = entities[i]
            
            entity.point.world(
                center: center
            )
            
            let a = entity.point
            
            let x = Float(a.x / project.x)
            let y = Float(a.y / project.y)
            let z: Float = 0
            
            let xData = Data.float(x)
            let yData = Data.float(y)
            let zData = Data.float(z)
            
            print(xData, yData, zData)
            
            data.append(
                xData
            )
            
            data.append(
                yData
            )
            
            data.append(
                zData
            )
            
            guard let dataObjName = entity.objName
                .data(
                    using: .ascii
                ) else {
                data.append(
                    zeroData
                )
                continue
            }
            
            data.append(
                [UInt8(dataObjName.count)],
                count: 1 // byte
            )
            
            data.append(
                dataObjName
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
        
        let count = Int(data[0])
        let coordBytes = 4
        
        let coordsLen = 3 * coordBytes
        
        let countBytes = count * coordsLen
        var i = 1
        
        var points: [CGPoint] = []
        
        while i < countBytes {
            
            print("WHILE:")
            
            let x: Float = data[i..<(i+4)]
                .float()
            
            i += coordBytes
            
            let y: Float = data[i..<(i+4)]
                .float()
            
            i += coordBytes
            
            let _: Float = data[i..<(i+4)]
                .float()
            
            i += coordBytes
            
            print(x,y)
            
            i += coordsLen
            
            points.append(
                CGPoint(
                    x: CGFloat(x),
                    y: CGFloat(y)
                )
            )
        }
        
        return points
    }
    
}
