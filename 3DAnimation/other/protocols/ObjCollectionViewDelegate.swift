//
//  ObjCollectionViewDelegate.swift
//  3DAnimation
//
//  Created by GoodDamn on 26/02/2024.
//

import Foundation

protocol ObjCollectionViewDelegate
    : AnyObject {
    
    func onSelectObject(
        name: String?
    )
    
}
