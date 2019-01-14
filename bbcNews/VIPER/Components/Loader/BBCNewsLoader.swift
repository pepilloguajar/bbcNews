//
//  BBCNewsLoader.swift
//  BBCNews
//
//  Created by Luis Alberto Mendoza Reyna on 14/11/2018.
//  Copyright © 2018 Jose Javier Montes Romero. All rights reserved.
//

import UIKit
import Lottie

class BBCNewsLoader: UIView {
    
    var animationView: LOTAnimationView = LOTAnimationView(name: "loader")
    
    @IBOutlet weak var loaderView: UIView!
    // MARK: LIFE CYCLE
    class func instanceFromNib() -> UIView {
        return (UINib(nibName: "BBCNewsLoader", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as? UIView) ?? UIView()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        animationView.contentMode = .scaleAspectFill
        animationView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        animationView.tintColor = UIColor.black
        
        self.loaderView.addSubview(animationView)
        animationView.loopAnimation = true
        animationView.play()
    }
    
    // MARK: PUBLIC
    class func showProgressHud(fullScreen: Bool = true, isGlobalPositionIpad: Bool = false) {
        
        DispatchQueue.main.async {
            
            let window = UIApplication.shared.windows[0]
            
            // Si ya existe un loader, no añade ninguno nuevo.
            let checkIfExist = window.viewWithTag(12345)
            
            if checkIfExist as? BBCNewsLoader == nil {
                
                guard let hudView = BBCNewsLoader.instanceFromNib() as? BBCNewsLoader else {
                    return
                }
                // Bajamos la vista del loader por debajo de la barra de navegación
                hudView.frame = fullScreen ? window.bounds : CGRect(x: 0.0, y: 44 + UIApplication.shared.statusBarFrame.height, width: window.bounds.width, height: window.bounds.height - (44 + UIApplication.shared.statusBarFrame.height))
                
                // Modificamos el frame si estamos en la posición global de iPad debido a que la cabecera es más grande
                if isGlobalPositionIpad {
                    hudView.frame = CGRect(x: 0.0, y: 84 + UIApplication.shared.statusBarFrame.height, width: window.bounds.width, height: window.bounds.height - (84 + UIApplication.shared.statusBarFrame.height))
                }
                
                hudView.tag = 12345
                window.addSubview(hudView)
            }
        }
    }
    
    class func hideProgressHud() {
        DispatchQueue.main.async {
            let window = UIApplication.shared.windows[0]
            for view in window.subviews where view is BBCNewsLoader {
                view.removeFromSuperview()
            }
        }
    }
    
    class func showProgressHudInView(view: UIView) {
        
        DispatchQueue.main.async {
            
            // Si ya existe un loader, no añade ninguno nuevo.
            let checkIfExist = view.viewWithTag(12345)
            
            if checkIfExist as? BBCNewsLoader == nil {
                
                guard let hudView = BBCNewsLoader.instanceFromNib() as? BBCNewsLoader else {
                    return
                }
                hudView.frame = view.bounds
                hudView.tag = 12345
                view.addSubview(hudView)
            }
        }
    }
    
    class func hideProgressHudInView(view: UIView) {
        DispatchQueue.main.async {
            for view in view.subviews where view is BBCNewsLoader {
                view.removeFromSuperview()
            }
        }
    }
}
