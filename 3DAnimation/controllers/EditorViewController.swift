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
    
    override func loadView() {
        super.loadView()
        mGrid = GridView(
            frame: UIScreen
                .main
                .bounds
        )
        
        mGrid.row = 10
        mGrid.cols = 10
        
        view = mGrid
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
    }
}

extension EditorViewController {
    
    override func touchesEnded(
        _ touches: Set<UITouch>,
        with event: UIEvent?
    ) {
        guard let touch = touches.first else {
            return
        }
        
        mGrid.addPoint(
            touch.location(
                in: mGrid
            )
        )
    }
    
}

