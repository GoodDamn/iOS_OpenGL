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
    
    private var mObjCollectionView:
        ObjCollectionView!
    
    private var mObjNameSelected: String? = nil
    
    override func viewWillDisappear(
        _ animated: Bool
    ) {
        super.viewWillDisappear(animated)
        
        FileSkl.write(
            entities: &mGrid.mEntities,
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
        
        let w = mGrid.frame.width
        let h = mGrid.frame.height
        
        mObjCollectionView = ObjCollectionView(
            frame: CGRect(
                x: 0,
                y: h * 0.7,
                width: w,
                height: h * 0.3
            ),
            direction: .horizontal
        )
        
        mObjCollectionView.delegateObj = self
        
        view.addSubview(
            mObjCollectionView
        )
    }
    
}

extension EditorViewController
    : ObjCollectionViewDelegate {
    
    func onSelectObject(
        name: String?
    ) {
        mObjNameSelected = name
    }
    
}

extension EditorViewController {
    
    override func touchesEnded(
        _ touches: Set<UITouch>,
        with event: UIEvent?
    ) {
        guard let touch = touches.first,
            let objName = mObjNameSelected else {
            return
        }
        
        mGrid.addEntity(
            touch.location(
                in: mGrid
            ),
            objName: objName
        )
    }
    
}

