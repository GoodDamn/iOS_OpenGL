//
//  UInt8.swift
//  3DAnimation
//
//  Created by GoodDamn on 27/02/2024.
//

import Foundation

extension UInt8 {
    
    func sign() -> Int8 {
        Int8(
            truncatingIfNeeded: self
        )
    }
    
}
