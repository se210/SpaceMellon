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
    
    //var gameTitle: UILabel!
    var playButton: UIButton!
    
    var optionButton: UIButton!
    var creditButton: UIButton!
    var quitButton: UIButton!
    
    let screenBounds = UIScreen.mainScreen().bounds
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backgroundImage = UIImage(named: "Background")
        let backgroundImageView = UIImageView(image: backgroundImage)
        backgroundImageView.center = CGPoint(x: CGRectGetMidX(screenBounds), y: CGRectGetMidY(screenBounds))
        
        let darkOverlay = UIView(frame: screenBounds)
        darkOverlay.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.15)
        
        self.view.addSubview(backgroundImageView)
        self.view.addSubview(darkOverlay)
        
        let titleImage = UIImage(named: "SpaceMellon")
        let titleImageView = UIImageView(image: titleImage)
        titleImageView.center = CGPoint(x: CGRectGetMidX(screenBounds), y: CGRectGetMaxY(screenBounds) * 0.20)
        self.view.addSubview(titleImageView)
        
        //gameTitle = UILabel(frame: CGRectMake(0,0,300,30))
        //gameTitle.text = "MellonRunker"
        //gameTitle.font = UIFont(name: "HelveticaNeue-Light", size: 30)
        //gameTitle.textAlignment = .Center
        //gameTitle.textColor = UIColor.blackColor()
        //gameTitle.center = CGPoint(x: CGRectGetMidX(screenBounds), y: CGRectGetMaxY(screenBounds) * 0.20)
        
        playButton = UIButton(frame: CGRectMake(0,0,200,21))
        playButton.setTitleColor(UIColor.greenColor(), forState: UIControlState.Normal)
        playButton.setTitle("Play!", forState: UIControlState.Normal)
        playButton.center = CGPoint(x: CGRectGetMidX(screenBounds), y: CGRectGetMaxY(screenBounds) * 0.40)
        //playButton.center = CGPoint(x: CGRectGetMaxX(screenBounds) * 0.75, y: CGRectGetMaxY(screenBounds) * 0.85)
        playButton.addTarget(self, action: "play:", forControlEvents: UIControlEvents.TouchUpInside)
        
        optionButton = UIButton(frame: CGRectMake(0,0,200,21))
        optionButton.setTitleColor(UIColor.greenColor(), forState: UIControlState.Normal)
        optionButton.setTitle("Option", forState: UIControlState.Normal)
        optionButton.center = CGPoint(x: CGRectGetMidX(screenBounds), y: CGRectGetMaxY(screenBounds) * 0.50)
        
        creditButton = UIButton(frame: CGRectMake(0,0,200,21))
        creditButton.setTitleColor(UIColor.greenColor(), forState: UIControlState.Normal)
        creditButton.setTitle("Credits", forState: UIControlState.Normal)
        creditButton.center = CGPoint(x: CGRectGetMidX(screenBounds), y: CGRectGetMaxY(screenBounds) * 0.60)
        
        
        //self.view.addSubview(gameTitle)
        self.view.addSubview(playButton)
        self.view.addSubview(optionButton)
        self.view.addSubview(creditButton)
    }
    
    func play(sender: UIButton) {
        performSegueWithIdentifier("LoadGame", sender: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}