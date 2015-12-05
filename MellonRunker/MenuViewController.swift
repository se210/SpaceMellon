//
//  MenuViewController.swift
//  MellonRunker
//
//  Created by Gihyuk Ko on 12/5/15.
//  Copyright © 2015 Gihyuk Ko and Se-Joon Chung. All rights reserved.
//

import UIKit

// Menu View Controller Class
class MenuViewController: UIViewController {
    
    var diffTitle: UILabel!
    var playButton: UIButton!
    //var easyButton: UIButton!
    //var mediumButton: UIButton!
    //var hardButton: UIButton!
    
    let screenBounds = UIScreen.mainScreen().bounds
    
    override func viewDidLoad() {
        super.viewDidLoad()
        diffTitle = UILabel(frame: CGRectMake(0,0,300,30))
        diffTitle.text = "MellonRunker"
        diffTitle.font = UIFont(name: "HelveticaNeue-Light", size: 30)
        diffTitle.textAlignment = .Center
        diffTitle.textColor = UIColor.blackColor()
        diffTitle.center = CGPoint(x: CGRectGetMidX(screenBounds), y: CGRectGetMaxY(screenBounds) * 0.20)
        playButton = UIButton(frame: CGRectMake(0,0,200,21))
        playButton.setTitleColor(UIColor.greenColor(), forState: UIControlState.Normal)
        playButton.setTitle("Play!", forState: UIControlState.Normal)
        playButton.center = CGPoint(x: CGRectGetMaxX(screenBounds) * 0.75, y: CGRectGetMaxY(screenBounds) * 0.85)
        playButton.addTarget(self, action: "play:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(diffTitle)
        self.view.addSubview(playButton)
        //easyButton.center = CGPoint(x: CGRectGetMidX(screenBounds), y: CGRectGetMaxY(screenBounds) * 0.40)
        //mediumButton.center = CGPoint(x: CGRectGetMidX(screenBounds), y: CGRectGetMaxY(screenBounds) * 0.50)
        //hardButton.center = CGPoint(x: CGRectGetMidX(screenBounds), y: CGRectGetMaxY(screenBounds) * 0.60)
    }
    
    func play(sender: UIButton) {
        performSegueWithIdentifier("LoadGame", sender: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}