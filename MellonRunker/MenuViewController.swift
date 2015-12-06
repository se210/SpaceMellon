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
    var volumeButton: UIButton!
    var optionButton: UIButton!
    var creditButton: UIButton!
    var quitButton: UIButton!
    var creditBox: UIButton!
    var optionBox: UIButton!
    
    var volume: Bool = true
    var credit: Bool = false
    var option: Bool = false
    
    let screenBounds = UIScreen.mainScreen().bounds
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backgroundImage = UIImage(named: "Background")
        let backgroundImageView = UIImageView(image: backgroundImage)
        backgroundImageView.center = CGPoint(x: CGRectGetMidX(screenBounds), y: CGRectGetMidY(screenBounds))
        
        self.view.addSubview(backgroundImageView)
        
        let titleImage = UIImage(named: "SpaceMellon")
        let titleImageView = UIImageView(image: titleImage)
        titleImageView.center = CGPoint(x: CGRectGetMidX(screenBounds), y: CGRectGetMaxY(screenBounds) * 0.20)
        self.view.addSubview(titleImageView)
        
        playButton = UIButton(frame: CGRectMake(0,0,150,150))
        playButton.setBackgroundImage(UIImage(named: "play"), forState: UIControlState.Normal)
        playButton.alpha = 0.8
        playButton.center = CGPoint(x: CGRectGetMidX(screenBounds), y: CGRectGetMaxY(screenBounds) * 0.55)
        playButton.addTarget(self, action: "play:", forControlEvents: UIControlEvents.TouchUpInside)
        
        volumeButton = UIButton(frame: CGRectMake(0,0,50,50))
        volumeButton.setBackgroundImage(UIImage(named: "volumeon"), forState: UIControlState.Normal)
        volumeButton.alpha = 0.6
        volumeButton.addTarget(self, action: "volumetoggle:", forControlEvents: UIControlEvents.TouchUpInside)
        volumeButton.center = CGPoint(x: CGRectGetMidX(screenBounds)*1/2, y: CGRectGetMaxY(screenBounds) * 0.85)
        
        optionButton = UIButton(frame: CGRectMake(0,0,50,50))
        optionButton.setBackgroundImage(UIImage(named: "option"), forState: UIControlState.Normal)
        optionButton.alpha = 0.85
        optionButton.addTarget(self, action: "option:", forControlEvents: UIControlEvents.TouchUpInside)
        optionButton.center = CGPoint(x: CGRectGetMidX(screenBounds), y: CGRectGetMaxY(screenBounds) * 0.85)
        
        creditButton = UIButton(frame: CGRectMake(0,0,50,50))
        creditButton.setBackgroundImage(UIImage(named: "credit"), forState: UIControlState.Normal)
        creditButton.alpha = 0.85
        creditButton.addTarget(self, action: "credittoggle:", forControlEvents: UIControlEvents.TouchUpInside)
        creditButton.center = CGPoint(x: CGRectGetMidX(screenBounds)*3/2, y: CGRectGetMaxY(screenBounds) * 0.85)
        
        self.view.addSubview(playButton)
        self.view.addSubview(volumeButton)
        self.view.addSubview(optionButton)
        self.view.addSubview(creditButton)
        
        creditBox = UIButton(frame: CGRectMake(0,0,300,300))
        creditBox.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.8)
        creditBox.center = CGPoint(x: CGRectGetMidX(screenBounds), y: CGRectGetMaxY(screenBounds) * 0.55)
        self.creditBox.hidden = true
        self.view.addSubview(self.creditBox)

        optionBox = UIButton(frame: CGRectMake(0,0,300,300))
        optionBox.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.8)
        optionBox.center = CGPoint(x: CGRectGetMidX(screenBounds), y: CGRectGetMaxY(screenBounds) * 0.55)
        self.optionBox.hidden = true
        self.view.addSubview(self.optionBox)
    }
    
    func play(sender: UIButton) {
        performSegueWithIdentifier("LoadGame", sender: self)
    }
    
    func volumetoggle(sender: UIButton) {
        if (self.volume) {
            self.volumeButton.setBackgroundImage(UIImage(named: "volumeoff"), forState: UIControlState.Normal)
            self.volume = false
        } else {
            self.volumeButton.setBackgroundImage(UIImage(named: "volumeon"), forState: UIControlState.Normal)
            self.volume = true
        }
    }
    
    func option(sender: UIButton) {
        if (!self.option) {
            self.optionBox.hidden = false
            self.option = true
            self.creditBox.hidden = true
            self.credit = false
            self.playButton.hidden = true
            
        } else {
            self.optionBox.hidden = true
            self.option = false
            self.creditBox.hidden = true
            self.credit = false
            self.playButton.hidden = false
        }
    }
    
    func credittoggle(sender: UIButton) {
        if (!self.credit) {
            self.creditBox.hidden = false
            self.credit = true
            self.optionBox.hidden = true
            self.option = false
            self.playButton.hidden = true
        } else {
            self.creditBox.hidden = true
            self.credit = false
            self.optionBox.hidden = true
            self.option = false
            self.playButton.hidden = false
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}