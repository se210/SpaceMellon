//
//  GameViewController.swift
//  MellonRunker
//
//  Created by Gihyuk Ko on 11/16/15.
//  Copyright (c) 2015 Gihyuk Ko. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit
import SpriteKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let skView = self.view as! SKView
        
        if(skView.scene == nil)
        {
            skView.showsFPS = false
            skView.showsNodeCount = false
            skView.ignoresSiblingOrder = true
            
            let scene = GameScene(size: self.view.bounds.size)
            
            skView.presentScene(scene)
        }
    }
    
    override func shouldAutorotate() -> Bool {
        return true
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return .AllButUpsideDown
        } else {
            return .All
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

}
