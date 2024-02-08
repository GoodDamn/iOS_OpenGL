//
//  ViewController.swift
//  3DAnimation
//
//  Created by GoodDamn on 05/01/2024.
//

import UIKit
import GLKit

class ViewController
    : GLKViewController {

    private final let TAG = "ViewController"
    
    private final let mRenderer = MainRenderer()
    
    private var mPosRender: CGRect = .zero
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        guard let context = EAGLContext(
            api: .openGLES3
        ) else {
            view.backgroundColor = .red
            return
        }
        
        let f = view.frame
        let scale = UIScreen.main.scale
        
        mPosRender = CGRect(
            x: 0,
            y: 0,
            width: f.width * scale,
            height: f.height * scale
        )
        
        
        print(TAG, "VIEW_FRAME:", f, "PX:",mPosRender, scale)
        
        
        let glView = GLKView(
            frame: f
        )
        
        glView.backgroundColor = .green
        
        view.addSubview(glView)
        glView.context = context
                
        glView.drawableColorFormat = .RGBA8888
        glView.drawableDepthFormat = .format16
        glView.drawableStencilFormat = .format8
        
        glView.drawableMultisample =
            .multisampleNone
        
        EAGLContext.setCurrent(
            context
        )
               
        delegate = self
        
        glView.delegate = self
        
        
    }

    override func glkView(
        _ view: GLKView,
        drawIn rect: CGRect
    ) {
        if !mRenderer.isCreated() {
            mRenderer.onCreate(mPosRender)
        }
        
        mRenderer.onDraw(mPosRender)
    }
    
}

extension ViewController:
    GLKViewControllerDelegate {
    
    func glkViewController(
        _ controller: GLKViewController,
        willPause pause: Bool
    ) {
        print(TAG, "glkViewController(wiilPause)")
    }
    
    func glkViewControllerUpdate(
        _ controller: GLKViewController
    ) {
        mRenderer
            .onUpdate(
                Float(controller
                    .timeSinceLastDraw)
            )
        controller
            .view!
            .subviews[0]
            .setNeedsDisplay()
    }
    
}
