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
    
    override func viewWillDisappear(
        _ animated: Bool
    ) {
        super.viewWillDisappear(animated)
        
        FileSkl.write(
            points: &mGrid.mPoints,
            fileName: "1.skl",
            project: CGPoint(
                x: mGrid.projectX,
                y: mGrid.projectY
            ),
            center: mGrid.center
        )
        
    }
    
    override func loadView() {
        super.loadView()
        mGrid = GridView(
            frame: UIScreen
                .main
                .bounds
        )
        
        mGrid.row = 10
        mGrid.cols = 10
        mGrid.backgroundColor = .white
        
        view = mGrid
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let objs = Bundle.files(
            ".obj"
        )
        
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

