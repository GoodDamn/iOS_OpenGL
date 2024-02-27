//
//  Bundle.swift
//  3DAnimation
//
//  Created by GoodDamn on 26/02/2024.
//

import Foundation

extension Bundle {
    
    static func files(
        _ ex: String
    ) -> [String]? {
        
        let bundle = Bundle.main
        
        guard let res = bundle.resourcePath else {
            return nil
        }
        
        guard let urls = try? FileManager
            .default
            .contentsOfDirectory(
                atPath: res
            ) else {
            return nil
        }
        
        return urls.filter {
            $0.contains(ex)
        }
    }
    
}
