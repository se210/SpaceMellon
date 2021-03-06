//
//  GameViewController.swift
//  SpaceMellon
//
//  Created by Gihyuk Ko on 11/16/15.
//  Copyright © 2015 Gihyuk Ko and Se-Joon Chung. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit
import SpriteKit

class GameViewController: UIViewController {
    
    var volume: Bool!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadGameScene()
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
    
    deinit
    {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func loadGameScene()
    {
        let skView = self.view as! SKView
        
        if(skView.scene == nil)
        {
            skView.showsFPS = false
            skView.showsNodeCount = false
            skView.ignoresSiblingOrder = true
            
            let scene = GameScene(size: self.view.bounds.size)
            scene.scaleMode = .AspectFill
            scene.volume = self.volume
            
            NSNotificationCenter.defaultCenter().addObserver(self, selector: "tryAgain:", name: "TryAgain", object: nil)
            
            skView.presentScene(scene)
        }
    }
    
    func tryAgain(notification: NSNotification)
    {
        let skView = self.view as! SKView
        skView.presentScene(nil)
        self.dismissViewControllerAnimated(true, completion: {() -> Void in
            self.performSegueWithIdentifier("TryAgain", sender: self)
        })
    }

}
