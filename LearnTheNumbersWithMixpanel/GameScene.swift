//
//  GameScene.swift
//  Tuco2
//
//  Created by Mirko Saiu on 02/02/15.
//  Copyright (c) 2015 Mirko Saiu. All rights reserved.
//

import SpriteKit
import Mixpanel
import AVFoundation



class GameScene: SKSceneSuper {

    let playButton = UIButton(type: UIButtonType.System)
    let restartButton = UIButton(type: UIButtonType.System)
    let continueButton = UIButton(type: UIButtonType.System)
    let facebookButton = UIButton(type: UIButtonType.System)
    let sentTipsButton = UIButton(type: UIButtonType.System)
    let vibur_font = UIFont(name: "Vibur", size: 50)
    var gain_the_assistant: UILabel!
    var feedbackCloud1: UILabel!
    var feedbackCloud2: UILabel!
    var title: UILabel!
    
    // LOCALIZATION
    let resume_string = NSLocalizedString("RESUME", comment: "")
    let play_string = NSLocalizedString("PLAY", comment: "")
    let restart_string = NSLocalizedString("RESTART", comment: "")
    let gain_assistant_string = NSLocalizedString("GAIN_ASSISTANT", comment: "")
    let share_on_fb_string = NSLocalizedString("SHARE_WITH_FRIENDS", comment: "")
    let send_feedback_string_1 = NSLocalizedString("SEND_FEEDBACK_1", comment: "")
    let send_feedback_string_2 = NSLocalizedString("SEND_FEEDBACK_2", comment: "")
    let parental_control_string = NSLocalizedString("PARENTAL_CONTROL", comment: "")
    let enter_result_string = NSLocalizedString("ENTER_RESULT", comment: "")
    
    
    override func didMoveToView(view: SKView) {
        super.didMoveToView(view)
        
        setBaseEnvironment()
        
        
        
        audio = setupAudioPlayerWithFile("piano-bells-happiness", type:"mp3")
        audio.numberOfLoops = -1
        audio.play()
        
        let isfirstPlay = userDefaults.valueForKey(defaultsKeys.isfirstPlay) as! Bool
        
        
        let greenButtonImage = UIImage(named: "play_button")!
        let orangeButtonImage = UIImage(named: "orange_button")!
        
        // PLAY BUTTON
        
        let playCenterX = view.center.x-greenButtonImage.size.width/2
        playButton.frame = CGRectMake(playCenterX, size.height/2, greenButtonImage.size.width, greenButtonImage.size.height)
        playButton.setBackgroundImage(greenButtonImage, forState: UIControlState.Normal)
        playButton.setTitle(play_string + "!", forState: UIControlState.Normal)
        playButton.tintColor = UIColor.whiteColor()
        playButton.addTarget(self, action: "play:", forControlEvents: UIControlEvents.TouchUpInside)
        playButton.titleLabel?.font = vibur_font
        
        
        
        if (isfirstPlay) {
            self.view!.addSubview(playButton)
        } else {
            
            // RESUME BUTTON
    
            let playCenterX = view.center.x-greenButtonImage.size.width/2
            continueButton.frame = CGRectMake(playCenterX, size.height/2-100, greenButtonImage.size.width, greenButtonImage.size.height)
            continueButton.setBackgroundImage(greenButtonImage, forState: UIControlState.Normal)
            continueButton.setTitle(resume_string, forState: UIControlState.Normal)
            continueButton.tintColor = UIColor.whiteColor()
            continueButton.addTarget(self, action: "resume:", forControlEvents: UIControlEvents.TouchUpInside)
            continueButton.titleLabel?.font = UIFont(name: "Vibur", size: 50)
            
            
            self.view!.addSubview(continueButton)
            
            
            // RESTART BUTTON
            
            restartButton.frame = CGRectMake(playCenterX, size.height/2, orangeButtonImage.size.width, orangeButtonImage.size.height)
            restartButton.setBackgroundImage(orangeButtonImage, forState: UIControlState.Normal)
            restartButton.setTitle(restart_string, forState: UIControlState.Normal)
            restartButton.tintColor = UIColor.whiteColor()
            restartButton.addTarget(self, action: "restart:", forControlEvents: UIControlEvents.TouchUpInside)
            restartButton.titleLabel?.font = UIFont(name: "Vibur", size: 50)
            
            
            self.view!.addSubview(restartButton)
            
            
        }
        
        
        
        
        
        
        
        // FACEBOOK BUTTON
        
        let shareButtonImage = UIImage(named: "fb_share_button")!
        let fbShareCenterX = view.center.x-shareButtonImage.size.width/2
        facebookButton.frame = CGRectMake(fbShareCenterX, height-170, shareButtonImage.size.width, shareButtonImage.size.height)
        facebookButton.setBackgroundImage(shareButtonImage, forState: UIControlState.Normal)
        facebookButton.setTitle(share_on_fb_string, forState: UIControlState.Normal)
        facebookButton.tintColor = UIColor.whiteColor()
        facebookButton.addTarget(self, action: "shareOnFacebook:", forControlEvents: UIControlEvents.TouchUpInside)
        facebookButton.titleLabel?.font = UIFont(name: "Vibur", size: 33)
        
        
        
        
        // FEEDBACK BUTTON
        
        let sentTipsButtonImage = UIImage(named: "feedback-cloud")!
        sentTipsButton.frame = CGRectMake(width-170, height/2-60, sentTipsButtonImage.size.width, sentTipsButtonImage.size.height)
        sentTipsButton.setBackgroundImage(sentTipsButtonImage, forState: UIControlState.Normal)
        sentTipsButton.addTarget(self, action: "sendEmail:", forControlEvents: UIControlEvents.TouchUpInside)
        
        
        // FEEDBACK BUTTON - INSIDE
        
        feedbackCloud1 = UILabel(frame: CGRectMake(width-140, height/2-45, sentTipsButton.frame.width, 30))
        feedbackCloud1.text = send_feedback_string_1
        feedbackCloud1.font = UIFont(name: "Vibur", size: 24)
        feedbackCloud1.textColor = UIColor(rgba: "#4273B9")
        view.addSubview(feedbackCloud1)
        feedbackCloud2 = UILabel(frame: CGRectMake(width-150, height/2-20, sentTipsButton.frame.width, 30))
        feedbackCloud2.text = send_feedback_string_2
        feedbackCloud2.font = UIFont(name: "Vibur", size: 21)
        feedbackCloud2.textColor = UIColor(rgba: "#4273B9")
        view.addSubview(feedbackCloud2)
        
        
        
        let isSharedOnFB = userDefaults.boolForKey(defaultsKeys.isSharedOnFacebook)

        if(!isSharedOnFB) {
            gain_the_assistant = UILabel(frame: CGRectMake(width/2 - 150, height-100, 380, 45))
            gain_the_assistant.text = "..." + gain_assistant_string
            gain_the_assistant.font = UIFont(name: "Vibur", size: 34)
            gain_the_assistant.textColor = UIColor(rgba: "#21326E")
            view.addSubview(gain_the_assistant)
        }
        
        self.view!.addSubview(facebookButton)
        self.view!.addSubview(sentTipsButton)
        
        /* FACEBOOK LOGIN
        let loginButton: FBSDKLoginButton = FBSDKLoginButton()
        loginButton.center = self.view!.center
        self.view!.addSubview(loginButton)*/
    }
    
    func sendEmail(sender: UIButton!) {
        let controller = self.view?.window?.rootViewController as! GameViewController

        gateParental(
            { () -> Void in
                self.mixpanel.track("Send feedback button clicked")
                controller.sendEmailButtonTapped()
            },
            ifFail: { () -> Void in
                self.mixpanel.track("Fail on the parental control (send email)")
            }
        )
    }
    
    
    // SHARE ON FACEBOOK
    func shareOnFacebook(sender: UIButton!) {
        let controller = self.view?.window?.rootViewController as! GameViewController

        gateParental(
            { () -> Void in
                self.mixpanel.track("Share on facebook button clicked")
                controller.showShareDialog()
            },
            ifFail: { () -> Void in
                self.mixpanel.track("Fail on the parental control (share on facebook)")
            }
        )
    }
    
    
    func gateParental(ifSuccess: Void -> Void, ifFail: Void -> Void)  {
        let controller = self.view?.window?.rootViewController as! GameViewController

        let firstNum = Int(arc4random_uniform(UInt32(4)))
        let secondNum = Int(arc4random_uniform(UInt32(4)))
        let thirdNum = Int(arc4random_uniform(UInt32(4)))
        
        let result = firstNum * secondNum + thirdNum
        let operation2String = String(firstNum) + " x " + String(secondNum) + " + " + String(thirdNum) + " ="
        
        
        let alert = UIAlertController(title: parental_control_string, message: operation2String, preferredStyle: .Alert)

        
        
        alert.addTextFieldWithConfigurationHandler({ (textField) -> Void in
            textField.placeholder = self.enter_result_string
            textField.keyboardType = UIKeyboardType.DecimalPad
        })
        
        alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action) -> Void in
            let textField = alert.textFields![0] as UITextField
            
            if(textField.text == String(result)) {
                // IF SUCCESS HERE
                ifSuccess()
            } else {
                // IF FAIL HERE
                ifFail()
            }
            
        }))
        
        
        controller.presentViewController(alert, animated: true, completion: nil)
    }
    
    
    // REMOVE OBJECTS FROM SUBVIEW
    func removeObjectsFromSubview() {
        playButton.removeFromSuperview()
        restartButton.removeFromSuperview()
        continueButton.removeFromSuperview()
        sentTipsButton.removeFromSuperview()
        facebookButton.removeFromSuperview()
        feedbackCloud1.removeFromSuperview()
        feedbackCloud2.removeFromSuperview()
        let isSharedOnFB = userDefaults.boolForKey(defaultsKeys.isSharedOnFacebook)
        if(!isSharedOnFB) {
            gain_the_assistant.removeFromSuperview()
        }
    }
    
    
    
    func play(sender: UIButton!) {
        
        mixpanel.track("Play button clicked")
        
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setBool(false, forKey: defaultsKeys.isfirstPlay)
        
        defaults.synchronize()
        
        removeObjectsFromSubview()
        
        let level: SKScene = Level1(size: self.size)
        level.scaleMode = scaleMode
        let transition = SKTransition.fadeWithDuration(1)
        view!.presentScene(level, transition: transition)
    }
    
    
    
    // RESUME
    func resume(sender: UIButton!) {
        
        mixpanel.track("Resume button clicked")
        
        
        removeObjectsFromSubview()
        presentNextLevel()
    }
    
    
    
    func restart(sender: UIButton!) {
        
        mixpanel.track("Restart button clicked")
        
        userDefaults.setInteger(1, forKey: defaultsKeys.level)
        userDefaults.setInteger(1, forKey: defaultsKeys.complexity)
        userDefaults.setBool(true, forKey: defaultsKeys.isfirstPlay)
        userDefaults.synchronize()
        
        
        playButton.removeFromSuperview()
        restartButton.removeFromSuperview()
        continueButton.removeFromSuperview()
        
        self.view!.addSubview(playButton)
        
        
    }
    
    
    
    
}
