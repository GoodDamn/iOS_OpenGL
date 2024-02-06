//
//  Strins.swift
//  3DAnimation
//
//  Created by GoodDamn on 06/02/2024.
//

import Foundation

extension String {
    
    func split(
        regex pattern: String
    ) -> [String] {
        
        guard let re = try? NSRegularExpression(
            pattern: pattern,
            options: []
        ) else {
            return []
        }
          
        let ns = self as NSString
        let stop = "!"
        
        let modified = re.stringByReplacingMatches(
            in: self,
            range: NSRange(
                location: 0,
                length: ns.length
            ),
            withTemplate: stop
        )
        
        return modified.components(
            separatedBy: stop
        )
    }
    
}
