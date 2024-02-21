//
//  EditorViewController.swift
//  3DAnimation
//
//  Created by GoodDamn on 20/02/2024.
//

import Foundation
import UIKit

final class EditorViewController
    : UIViewController {
    
    private var mGrid: GridView? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mGrid = GridView(
            frame: view.frame
        )
        
    }

}

extension EditorViewController {
    
    override func touchesBegan(
        _ touches: Set<UITouch>,
        with event: UIEvent?
    ) {
        
    }
    
}

