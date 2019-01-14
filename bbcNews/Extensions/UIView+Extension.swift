//
//  UIView+Extension.swift
//  JiboReminderHealthcare
//
//  Created by Marco Antonio Uzcategui Pescozo on 19/03/2018.
//  Copyright © 2018 Marco Antonio Uzcategui Pescozo. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func addSubviewWithConstraints(_ insets: UIEdgeInsets, subView: UIView) {
        
        self.addSubview(subView)
        subView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addConstraint(NSLayoutConstraint(item: subView,
                                              attribute: .top,
                                              relatedBy: .equal,
                                              toItem: self,
                                              attribute: .top,
                                              multiplier: 1.0,
                                              constant: insets.top))
        
        self.addConstraint(NSLayoutConstraint(item: subView,
                                              attribute: .trailing,
                                              relatedBy: .equal,
                                              toItem: self,
                                              attribute: .trailing,
                                              multiplier: 1.0,
                                              constant: insets.right))
        
        self.addConstraint(NSLayoutConstraint(item: subView,
                                              attribute: .bottom,
                                              relatedBy: .equal,
                                              toItem: self,
                                              attribute: .bottom,
                                              multiplier: 1.0,
                                              constant: insets.bottom))
        
        self.addConstraint(NSLayoutConstraint(item: subView,
                                              attribute: .leading,
                                              relatedBy: .equal,
                                              toItem: self,
                                              attribute: .leading,
                                              multiplier: 1.0,
                                              constant: insets.left))
        
        subView.layoutIfNeeded()
    }
    
    func createImage() -> UIImage {
        
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, 0.0)
        self.layer.render(in: UIGraphicsGetCurrentContext()!)
        let img: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return img!
    }
    
    func createImage(deg degrees: CGFloat) -> UIImage {
        
        var image = self.createImage()
        image = self.imageRotatedByDegrees(oldImage: image, deg: degrees)
        
        return image
    }
    
    func imageRotatedByDegrees(oldImage: UIImage, deg degrees: CGFloat) -> UIImage {
        
        //Calculate the size of the rotated view's containing box for our drawing space
        let rotatedViewBox: UIView = UIView(frame: CGRect(x: 0, y: 0, width: oldImage.size.width, height: oldImage.size.height))
        let trans: CGAffineTransform = CGAffineTransform(rotationAngle: degrees * CGFloat.pi / 180)
        rotatedViewBox.transform = trans
        let rotatedSize: CGSize = rotatedViewBox.frame.size
        //Create the bitmap context
        UIGraphicsBeginImageContext(rotatedSize)
        let bitmap: CGContext = UIGraphicsGetCurrentContext()!
        //Move the origin to the middle of the image so we will rotate and scale around the center.
        bitmap.translateBy(x: rotatedSize.width / 2, y: rotatedSize.height / 2)
        //Rotate the image context
        bitmap.rotate(by: (degrees * CGFloat.pi / 180))
        //Now, draw the rotated/scaled image into the context
        bitmap.scaleBy(x: 1.0, y: -1.0)
        bitmap.draw(oldImage.cgImage!, in: CGRect(x: -oldImage.size.width / 2, y: -oldImage.size.height / 2, width: oldImage.size.width, height: oldImage.size.height))
        let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
    
    func searchScroll(view: UIView) -> UIScrollView? {
        
        if view.superview == nil {
            
            return nil
            
        } else if (view.superview?.isKind(of: UIScrollView.self))! {
            
            if let view = view.superview as? UIScrollView {
                return (view)
            } else {
                return nil
            }
            
        } else {
            
            return self.searchScroll(view: view.superview!)
        }
    }
    
    public class func createComponentFromXIB<T: UIView>(viewType: T.Type) -> T? {
        if let component: T = Bundle.main.loadNibNamed(String(describing: viewType), owner: nil, options: nil)?.first as? T {
            component.translatesAutoresizingMaskIntoConstraints = false
            return component
        }
        
        return nil
    }
    
    func applyGradient(colours: [UIColor]) {
        self.applyGradient(colours: colours, locations: nil)
    }
    
    func applyGradient(colours: [UIColor], locations: [NSNumber]?) {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.cgColor }
        gradient.locations = locations
        self.layer.insertSublayer(gradient, at: 0)
    }
}
