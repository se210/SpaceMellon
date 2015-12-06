//
//  MenuViewController.swift
//  SpaceMellon
//
//  Created by Gihyuk Ko on 12/5/15.
//  Copyright © 2015 Gihyuk Ko and Se-Joon Chung. All rights reserved.
//

import UIKit
import AVFoundation

// Menu View Controller Class
class MenuViewController: UIViewController {
    
    //var gameTitle: UILabel!
    var playButton: UIButton!
    var volumeButton: UIButton!
    //var optionButton: UIButton!
    var creditButton: UIButton!
    var quitButton: UIButton!
    var creditBox: UIButton!
    var creditLabel: UILabel!
    //var optionBox: UIButton!
    
    var volume: Bool = true
    var credit: Bool = false
    var option: Bool = false
    
    var bgmPlayer = AVAudioPlayer()
    
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
        playButton.center = CGPoint(x: CGRectGetMidX(screenBounds), y: CGRectGetMaxY(screenBounds) * 0.525)
        playButton.addTarget(self, action: "play:", forControlEvents: UIControlEvents.TouchUpInside)
        
        volumeButton = UIButton(frame: CGRectMake(0,0,50,50))
        volumeButton.setBackgroundImage(UIImage(named: "volumeon"), forState: UIControlState.Normal)
        volumeButton.alpha = 0.6
        volumeButton.addTarget(self, action: "volumetoggle:", forControlEvents: UIControlEvents.TouchUpInside)
        volumeButton.center = CGPoint(x: CGRectGetMidX(screenBounds)*2/3, y: CGRectGetMaxY(screenBounds) * 0.85)
        
        /*
        optionButton = UIButton(frame: CGRectMake(0,0,50,50))
        optionButton.setBackgroundImage(UIImage(named: "option"), forState: UIControlState.Normal)
        optionButton.alpha = 0.85
        optionButton.addTarget(self, action: "option:", forControlEvents: UIControlEvents.TouchUpInside)
        optionButton.center = CGPoint(x: CGRectGetMidX(screenBounds), y: CGRectGetMaxY(screenBounds) * 0.85)
        */

        creditButton = UIButton(frame: CGRectMake(0,0,50,50))
        creditButton.setBackgroundImage(UIImage(named: "credit"), forState: UIControlState.Normal)
        creditButton.alpha = 0.85
        creditButton.addTarget(self, action: "credittoggle:", forControlEvents: UIControlEvents.TouchUpInside)
        creditButton.center = CGPoint(x: CGRectGetMidX(screenBounds)*4/3, y: CGRectGetMaxY(screenBounds) * 0.85)
        
        self.view.addSubview(playButton)
        self.view.addSubview(volumeButton)
        //self.view.addSubview(optionButton)
        self.view.addSubview(creditButton)
        
        creditBox = UIButton(frame: CGRectMake(0,0,350,250))
        creditBox.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.8)
        creditBox.center = CGPoint(x: CGRectGetMidX(screenBounds), y: CGRectGetMaxY(screenBounds) * 0.55)
        self.creditBox.hidden = true
        self.view.addSubview(self.creditBox)
        
        creditLabel = UILabel(frame: CGRectMake(0,0,300,200))
        creditLabel.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.6)
        creditLabel.center = CGPoint(x: CGRectGetMidX(screenBounds), y: CGRectGetMaxY(screenBounds) * 0.55)
        creditLabel.numberOfLines = 0
        creditLabel.textColor = UIColor.whiteColor().colorWithAlphaComponent(0.8)
        creditLabel.font = UIFont(name: "HelveticaNeue-Light", size: 11)
        creditLabel.textAlignment = .Justified
        let creditText: String = "SpaceMellon\n\nCreated by Gihyuk Ko and Se-Joon Chung of Carnegie Mellon University.\nMotivated from 98-222 Introduction to iOS Development class as a final project.\nMost icons and logos we have used are from opengameart.org and logomaker.com, where both sites kindly provides free-to-use icons and logos.\nHave fun!!\n\n Copyright © 2015 Gihyuk Ko and Se-Joon Chung. \n All rights reserved."
        let mutableString = NSMutableAttributedString(string: creditText,
                                        attributes: [NSFontAttributeName:UIFont(name: "HelveticaNeue-Light", size: 11.0)!])
        mutableString.addAttribute(NSFontAttributeName, value: UIFont(name: "HelveticaNeue-Light", size: 20.0)!, range: NSRange(location:0,length:11))
        mutableString.addAttribute(NSForegroundColorAttributeName, value: UIColor.cyanColor().colorWithAlphaComponent(0.6), range: NSRange(location:206,length:15))
        mutableString.addAttribute(NSForegroundColorAttributeName, value: UIColor.cyanColor().colorWithAlphaComponent(0.6), range: NSRange(location:226,length:13))
        creditLabel.attributedText = mutableString
        self.creditLabel.hidden = true
        self.view.addSubview(self.creditLabel)
        
        /*
        optionBox = UIButton(frame: CGRectMake(0,0,300,300))
        optionBox.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.8)
        optionBox.center = CGPoint(x: CGRectGetMidX(screenBounds), y: CGRectGetMaxY(screenBounds) * 0.55)
        self.optionBox.hidden = true
        self.view.addSubview(self.optionBox)
        */
        
        let bgmURL = NSBundle.mainBundle().URLForResource("menubgm", withExtension: "wav")!
        do {
            try bgmPlayer = AVAudioPlayer(contentsOfURL: bgmURL, fileTypeHint:nil)
            bgmPlayer.prepareToPlay()
        } catch {
            return print("No music file")
        }
        bgmPlayer.volume = 1
    }
    
    override func viewDidAppear(animated: Bool) {
        bgmPlayer.currentTime = 0
        bgmPlayer.numberOfLoops = -1
        bgmPlayer.play()
    }
    
    func play(sender: UIButton) {
        bgmPlayer.stop()
        performSegueWithIdentifier("LoadGame", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == nil) {
            return
        }
        switch segue.identifier! {
        case "LoadGame":
            if let gameViewController = segue.destinationViewController as? GameViewController {
                gameViewController.volume = self.volume;
            }
        default:
            break
        }
    }
    
    func volumetoggle(sender: UIButton) {
        if (self.volume) {
            self.volumeButton.setBackgroundImage(UIImage(named: "volumeoff"), forState: UIControlState.Normal)
            self.bgmPlayer.volume = 0
            self.volume = false
        } else {
            self.volumeButton.setBackgroundImage(UIImage(named: "volumeon"), forState: UIControlState.Normal)
            self.volume = true
            self.bgmPlayer.volume = 1
        }
    }
    
    func option(sender: UIButton) {
        if (!self.option) {
            //self.optionBox.hidden = false
            self.option = true
            self.creditBox.hidden = true
            self.creditLabel.hidden = true
            self.playButton.hidden = true
            
        } else {
            //self.optionBox.hidden = true
            self.option = false
            self.creditBox.hidden = true
            self.credit = false
            self.playButton.hidden = false
        }
    }
    
    func credittoggle(sender: UIButton) {
        if (!self.credit) {
            self.creditBox.hidden = false
            self.creditLabel.hidden = false
            self.credit = true
            //self.optionBox.hidden = true
            self.option = false
            self.playButton.hidden = true
        } else {
            self.creditBox.hidden = true
            self.creditLabel.hidden = true
            self.credit = false
            //self.optionBox.hidden = true
            self.option = false
            self.playButton.hidden = false
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}