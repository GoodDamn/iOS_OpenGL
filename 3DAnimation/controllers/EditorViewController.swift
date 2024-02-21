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
    
    private var mGrid: GridView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        mGrid = GridView(
            frame: view.frame
        )
        
        mGrid.row = 10
        mGrid.cols = 10
        
        view.addSubview(mGrid)
        
    }

}

extension EditorViewController {
    
    override func touchesBegan(
        _ touches: Set<UITouch>,
        with event: UIEvent?
    ) {
        
    }
    
}

