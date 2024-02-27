//
//  Data.swift
//  3DAnimation
//
//  Created by GoodDamn on 26/02/2024.
//

import Foundation

extension Data {
    
    static func val <T>(
        _ val: inout T
    ) -> Data {
        return Data(
            buffer: UnsafeBufferPointer(
                start: &val,
                count: 1
            )
        )
    }
    
    static func float(
        _ val: Float
    ) -> Data {
        let i = Int(val * 100.0)
        return (Data) ([
            UInt8((i >> 24) & 0xff),
            UInt8((i >> 16) & 0xff),
            UInt8((i >> 8) & 0xff),
            UInt8(i & 0xff)
        ])
    }
    
    func float() -> Float {
        return Float(integer()) / 100.0
    }
    
    func integer() -> Int {
        
        print("integer:", ([UInt8]) (self))
        
        return Int(self[startIndex].sign()) << 24 |
        Int(self[startIndex + 1].sign()) << 16 |
        Int(self[startIndex + 2].sign()) << 8 |
        Int(self[startIndex + 3].sign())
    }
    
    
    func val <T>() -> T {
        
        let s = ([UInt8])(self)
        
        for i in s {
            print("val:", String(i, radix: 2))
        }
        
        print("val:", s , MemoryLayout<T>.size)
        
        return withUnsafeBytes {
            $0.load(
                as: T.self
            )
        }
    }
    
}
