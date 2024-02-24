//
//  FileManage.swift
//  3DAnimation
//
//  Created by GoodDamn on 20/02/2024.
//

import Foundation

extension FileManager {
    
    func dirLevels() -> URL {
        let fm = FileManager
            .default
        
        let cache = fm.urls(
            for: .cachesDirectory,
            in: .userDomainMask
        )[0]
        
        print("dirLevels:",cache)
        
        let dir = cache.appendingPathComponent(
            "levels"
        )
        
        if !fm.fileExists(
            atPath: dir.path
        ) {
            try? fm.createDirectory(
                at: dir,
                withIntermediateDirectories: true
            )
        }
        
        return dir
    }
    
}
