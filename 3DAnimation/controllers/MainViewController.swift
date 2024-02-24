//
//  MainViewController.swift
//  3DAnimation
//
//  Created by GoodDamn on 20/02/2024.
//

import Foundation
import UIKit

final class MainViewController
    : UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        let w = view.frame.width
        let h = view.frame.height
        
        let btnEdit = UIButton(
            frame: CGRect(
                x: 0,
                y: 0,
                width: w,
                height: h * 0.5
            )
        )
        
        let btnPreview = UIButton(
            frame: CGRect(
                x: 0,
                y: h * 0.5,
                width: w,
                height: h * 0.5
            )
        )
        
        btnEdit.setTitleColor(
            .systemBlue,
            for: .normal
        )
        
        btnPreview.setTitleColor(
            .systemBlue,
            for: .normal
        )
        
        btnEdit.setTitle(
            "Editor",
            for: .normal
        )
        
        btnPreview.setTitle(
            "Preview",
            for: .normal
        )
        
        btnEdit.addTarget(
            self,
            action: #selector(
                onClickEditor(_:)
            ),
            for: .touchUpInside
        )
        
        btnPreview.addTarget(
            self,
            action: #selector(
                onClickPreview(_:)
            ),
            for: .touchUpInside
        )
        
        view.addSubview(btnPreview)
        view.addSubview(btnEdit)
        
    }
    
    @objc private func onClickEditor(
        _ sender: UIButton
    ) {
        navigationController?
            .pushViewController(
                EditorViewController(),
                animated: true
            )
    }
    
    @objc private func onClickPreview(
        _ sender: UIButton
    ) {
        navigationController?
            .pushViewController(
                PreviewController(),
                animated: true
            )
    }
}
