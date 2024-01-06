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
    
    private var mEntities: [Entity]? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        guard let context = EAGLContext(
            api: .openGLES3
        ) else {
            view.backgroundColor = .red
            return
        }
        
        
        let glView = GLKView(
            frame: view.frame
        )
        
        glView.backgroundColor = .green
        
        view.addSubview(glView)
        
        glView.context = context
                
        glView.drawableColorFormat = .RGBA8888
        glView.drawableDepthFormat = .format24
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
        
        if mEntities == nil {
            let p = Bundle
                .main
                .resourceURL!
                .appendingPathComponent(
                    "Sphere.obj"
                )
            
            print(TAG, p)
            mEntities = [
                Entity(
                    objectPath: p.path
                )
            ]
        }
        
        glClearColor(0.0,0.0,1.0,1.0)
        glClear(
            GLbitfield(
                GL_COLOR_BUFFER_BIT
            )
        )
        glViewport(
            GLint(0),
            GLint(0),
            GLsizei(view.frame.width),
            GLsizei(view.frame.height)
        )
        
        mEntities!.forEach { e in
            e.draw()
        }
        
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
    }
    
}
