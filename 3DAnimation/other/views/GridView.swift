//
//  GridView.swift
//  3DAnimation
//
//  Created by GoodDamn on 20/02/2024.
//

import Foundation
import UIKit

final class GridView
    : UIView {
    
    final var row = 5 {
        didSet {
            
        }
    }
    
    final var cols = 5 {
        didSet {
            
        }
    }
    
    private final let mLayer = CAShapeLayer()
    
    override init(
        frame: CGRect
    ) {
        super.init(
            frame: frame
        )
        
        layer.addSublayer(
            mLayer
        )
    }
    
    required init?(coder: NSCoder) {
        super.init(
            coder: coder
        )
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let p = UIBezierPath()
        
        let dx = rect.width / CGFloat(cols)
        let dy = rect.height / CGFloat(row)
        
        var curY: CGFloat = 0
        
        for _ in 0..<row {
            
            p.move(
                to: CGPoint(
                    x: 0,
                    y: curY
                )
            )
            
            p.addLine(
                to: CGPoint(
                    x: rect.width,
                    y: curY
                )
            )
            
            curY += dy
        }
        
        var curX: CGFloat = 0
        for _ in 0..<cols {
            
            p.move(
                to: CGPoint(
                    x: curX,
                    y: 0
                )
            )
            
            p.addLine(
                to: CGPoint(
                    x: curX,
                    y: rect.height
                )
            )
            
            curX += dx
        }
        
        mLayer.path = p.cgPath
        mLayer.fillColor = nil
        mLayer.strokeColor = UIColor.gray
            .cgColor
        
        mLayer.lineWidth = 2.0
        
    }
}
