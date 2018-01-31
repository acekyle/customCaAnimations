//
//  ViewController.swift
//  CaAnimations
//
//  Created by Aaron Anderson on 7/11/17.
//  Copyright © 2017 Aaron Anderson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    let redLayer: CALayer = {
        let layer = CALayer()
        layer.frame = CGRect(x: 50, y: 50, width: 100, height: 100)
        layer.backgroundColor = UIColor.red.cgColor
        layer.cornerRadius = 50
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 10
        return layer
    }()
    
    func setupLayer(){
        let imageLayer = CALayer()
        let image = #imageLiteral(resourceName: "iat-icon").cgImage
        
        imageLayer.frame = CGRect(x: 0, y: 100, width: (image?.width)!, height: (image?.height)!)
        imageLayer.contentsGravity = kCAGravityResizeAspect
        imageLayer.contentsScale = UIScreen.main.scale
        
        view.layer.addSublayer(redLayer)
        view.layer.addSublayer(imageLayer)
        
    }
    
    func runAnimation(completion: @escaping (_ success:Bool) -> ()) {
        let animation = CABasicAnimation(keyPath: "cornerRadius")
        animation.fromValue = redLayer.cornerRadius
        animation.toValue = 0
        animation.duration = 3
        animation.repeatCount = 1
        animation.autoreverses = true
        // Finally, add the animation to the layer
        redLayer.add(animation, forKey: "cornerRadius")

    }
    
    let randomView: AnimatedView = {
        let view = AnimatedView()
        view.backgroundColor = .orange
        view.frame = CGRect(x: 200, y: 100, width: 50, height: 50)
        view.jumpAnimation()
        return view
    }()
    
    let label:UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 10, width: 10, height: 10)
        label.backgroundColor = .purple
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        randomView.addSubview(label)
        view.addSubview(randomView)
        setupLayer()
        runAnimation { (success) in
            if success{
                    print("Closure Time Bitch!")
            }
            
        }
    }

    
    

}


class AnimatedView: UIView {
    
    func bringToScreen() {
        
        self.center.x -= UIScreen.main.bounds.width
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
            self.center.x += UIScreen.main.bounds.width
        }, completion: nil)
    }
    
    func jumpAnimation(){
        
        let animation = CABasicAnimation(keyPath: "position")
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x, y: self.center.y + 3))
        animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x, y: self.center.y - 2))
        animation.duration = 0.15
        animation.repeatCount = 5
        animation.autoreverses = true
        
        self.layer.add(animation, forKey: "position")
    }
    
    func flashBorderAnimation() {
        
        CATransaction.begin()
        
        self.layer.borderWidth = 2
        
        let animation = CABasicAnimation(keyPath: "borderColor")
        animation.fromValue = UIColor.clear.cgColor
        animation.toValue = UIColor.black.cgColor
        animation.duration = 0.5
        animation.repeatCount = 5
        animation.autoreverses = true
        
        CATransaction.setCompletionBlock { 
            print("Completion Block Bitch")
            self.layer.borderColor = UIColor.clear.cgColor
            self.layer.borderWidth = 0
            
        }
        
        self.layer.add(animation, forKey: "borderFlash")
        
        CATransaction.commit()
    }
    
    func rotateAnimation() {
        
        CATransaction.begin()

        let animation = CABasicAnimation(keyPath: "transform.rotation")
        animation.fromValue = 0
        animation.toValue = 0.2
        animation.duration = 0.05
        animation.repeatCount = 1
        animation.autoreverses = true
        
        CATransaction.setCompletionBlock {
            let animation = CABasicAnimation(keyPath: "transform.rotation")
            animation.fromValue = 0
            animation.toValue = -0.2
            animation.duration = 0.05
            animation.repeatCount = 2
            animation.autoreverses = true
            
            self.layer.add(animation, forKey: "rotate")
        }
        
        self.layer.add(animation, forKey: "rotate")
        
        CATransaction.commit()
    }
    
}
