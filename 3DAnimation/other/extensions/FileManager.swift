//
//  FileManager.swift
//  3DAnimation
//
//  Created by GoodDamn on 20/02/2024.
//

import Foundation

extension FileManager {
    
    static func readBundle(
        fileName: String
    ) -> Data? {
        
        guard let bundleUrl = Bundle
            .main
            .resourceURL else {
            return nil
        }
        
        let url = bundleUrl
            .appendingPathComponent(
                fileName
            )
        
        guard let data = FileManager.default
            .contents(
                atPath: url.path
            ) else {
            print("ERROR_READ_BUNDLE_DATA:")
            return nil
        }
        
        return data
    }
    
    static func readBundleString(
        fileName: String
    ) -> String? {
    
        guard let data = readBundle(
            fileName: fileName
        ) else {
            print("ERROR_READ_BUNDLE_FILE")
            return nil
        }
        
        return String(
            data: data,
            encoding: .utf8
        )
        
    }
    
}
