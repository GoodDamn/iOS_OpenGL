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
    
    final var projectX: CGFloat = 0
    final var projectY: CGFloat = 0
    
    final var row = 5
    final var cols = 5
    
    
    final var mPoints: [CGPoint] = []
    
    private final let mLayer =
        CAShapeLayer()
    
    private final let mPointsLayer =
        CAShapeLayer()
    
    override init(
        frame: CGRect
    ) {
        super.init(
            frame: frame
        )
        initial()
    }
    
    required init?(coder: NSCoder) {
        super.init(
            coder: coder
        )
        initial()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let pathGrid = UIBezierPath()
        let pathPoint = UIBezierPath()
        
        projectX = rect.width / CGFloat(cols)
        projectY = rect.height / CGFloat(row)
        
        var curY: CGFloat = 0
        
        for _ in 0..<row {
            
            pathGrid.move(
                to: CGPoint(
                    x: 0,
                    y: curY
                )
            )
            
            pathGrid.addLine(
                to: CGPoint(
                    x: rect.width,
                    y: curY
                )
            )
            
            curY += projectY
        }
        
        var curX: CGFloat = 0
        for _ in 0..<cols {
            
            pathGrid.move(
                to: CGPoint(
                    x: curX,
                    y: 0
                )
            )
            
            pathGrid.addLine(
                to: CGPoint(
                    x: curX,
                    y: rect.height
                )
            )
            
            curX += projectX
        }
        
        pathGrid.close()
        
        for point in mPoints {
            
            pathPoint.move(
                to: point
            )
            
            pathPoint.addArc(
                withCenter: point,
                radius: 5.0,
                startAngle: 0,
                endAngle: .pi * 2,
                clockwise: true
            )
            
        }
        
        pathPoint.close()
        
        mLayer.path = pathGrid.cgPath
        mLayer.fillColor = nil
        mLayer.strokeColor = UIColor.gray
            .cgColor
        mLayer.lineWidth = 2.0
        
        mPointsLayer.path = pathPoint.cgPath
    }
    
    
    
    final func addPoint(
        _ p: CGPoint
    ) {
        mPoints.append(
            p
        )
        
        setNeedsDisplay()
    }
    
    private final func initial() {
        layer.addSublayer(
            mLayer
        )
        
        mPointsLayer.fillColor = nil
        mPointsLayer.strokeColor = UIColor.red
            .cgColor
        mPointsLayer.lineWidth = 5
        
        layer.addSublayer(
            mPointsLayer
        )
    }
    
}
