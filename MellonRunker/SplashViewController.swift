//
//  SplashViewController.swift
//  MellonRunker
//
//  Created by Se-Joon Chung on 12/4/15.
//  Copyright © 2015 Gihyuk Ko and Se-Joon Chung. All rights reserved.
//

import UIKit
import SpriteKit

class SplashViewController: UIViewController
{
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Set background to black
        self.view.backgroundColor = SKColor.blackColor()
        
        // Load the logo image
        let logoImage = UIImage(named: "GHSJ")
        let logoImageView = UIImageView(image: logoImage!)
        logoImageView.center = self.view.center
        logoImageView.alpha = 0.0 // initially not visible
        self.view.addSubview(logoImageView)
        
        // Fade in
        let fadeInAnimation: CABasicAnimation = CABasicAnimation(keyPath: "opacity")
        fadeInAnimation.duration = 2.0
        fadeInAnimation.fromValue = 0.0
        fadeInAnimation.toValue = 1.0
        fadeInAnimation.beginTime = 0.0
        
        let staticAnimation: CABasicAnimation = CABasicAnimation(keyPath: "opacity")
        staticAnimation.duration = 1.0
        staticAnimation.fromValue = 1.0
        staticAnimation.toValue = 1.0
        staticAnimation.beginTime = 2.0
        
        // Fade out
        let fadeOutAnimation: CABasicAnimation = CABasicAnimation(keyPath: "opacity")
        fadeOutAnimation.duration = 2.0
        fadeOutAnimation.fromValue = 1.0
        fadeOutAnimation.toValue = 0.0
        fadeOutAnimation.beginTime = 3.0
        
        let animationGroup = CAAnimationGroup()
        animationGroup.duration = 5.0
        animationGroup.repeatCount = 1
        animationGroup.animations = [fadeInAnimation, staticAnimation, fadeOutAnimation]
        animationGroup.delegate = self
        
        logoImageView.layer.addAnimation(animationGroup, forKey: "logoAnimation")
    }
    
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        if (flag == true)
        {
            performSegueWithIdentifier("LoadMain", sender: self)
        }
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
