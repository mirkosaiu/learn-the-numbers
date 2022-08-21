//
//  GameScene.swift
//  learnthenumbers2022
//
//  Created by Mirko Saiu on 19/08/22.
//

import SpriteKit
import GameplayKit

import Social
import FacebookCore
import FacebookShare
import FacebookLogin


class GameScene: SKSceneSuper, SharingDelegate {
    
    let playButton = UIButton(type: UIButton.ButtonType.system)
    let restartButton = UIButton(type: UIButton.ButtonType.system)
    let continueButton = UIButton(type: UIButton.ButtonType.system)
    let facebookButton = UIButton(type: UIButton.ButtonType.system)
    let sentTipsButton = UIButton(type: UIButton.ButtonType.system)
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
    
    let website_url_string = NSLocalizedString("WEBSITE_URL", comment: "")

    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        setBaseEnvironment()
        
        
        audio = setupAudioPlayerWithFile(file: "piano-bells-happiness", type:"mp3")
        audio.numberOfLoops = -1
        audio.play()
        
        
        let isStarted = userDefaults.bool(forKey: defaultsKeys.isStarted)
        
        let greenButtonImage = UIImage(named: "play_button")!
        let orangeButtonImage = UIImage(named: "orange_button")!
        
        
        
        // PLAY BUTTON
    
        let playCenterX = view.center.x-greenButtonImage.size.width/2
        playButton.frame = CGRect(x: playCenterX, y: height/3, width: greenButtonImage.size.width, height: greenButtonImage.size.height)
        playButton.setBackgroundImage(greenButtonImage, for: UIControl.State.normal)
        playButton.setTitle(play_string + "!", for: UIControl.State.normal)
        playButton.tintColor = UIColor.white
        playButton.addTarget(self, action: #selector(play(_:)), for: UIControl.Event.touchUpInside)
        playButton.titleLabel?.font = vibur_font
        
        
        if (!isStarted) {
            self.view!.addSubview(playButton)
        }
        else {
            
            
            // RESUME BUTTON
    
            let playCenterX = view.center.x-greenButtonImage.size.width/2
            continueButton.frame = CGRect(x: playCenterX, y: height/2-100, width: greenButtonImage.size.width, height: greenButtonImage.size.height)
            continueButton.setBackgroundImage(greenButtonImage, for: UIControl.State.normal)
            continueButton.setTitle(resume_string, for: UIControl.State.normal)
            continueButton.tintColor = UIColor.white
            continueButton.addTarget(self, action: #selector(resume(_:)), for: UIControl.Event.touchUpInside)
            continueButton.titleLabel?.font = UIFont(name: "Vibur", size: 50)
            
            
            self.view!.addSubview(continueButton)
            
            
            // RESTART BUTTON
            
            restartButton.frame = CGRect(x: playCenterX, y: height/2, width: orangeButtonImage.size.width, height: orangeButtonImage.size.height)
            restartButton.setBackgroundImage(orangeButtonImage, for: UIControl.State.normal)
            restartButton.setTitle(restart_string, for: UIControl.State.normal)
            restartButton.tintColor = UIColor.white
            restartButton.addTarget(self, action: #selector(restart(_:)), for: UIControl.Event.touchUpInside)
            restartButton.titleLabel?.font = UIFont(name: "Vibur", size: 50)
            
            
            self.view!.addSubview(restartButton)
            
            
        }
        
        
        
        // FACEBOOK BUTTON
        
        let shareButtonImage = UIImage(named: "fb_share_button")!
        let fbShareCenterX = view.center.x-shareButtonImage.size.width/2
        facebookButton.frame = CGRect(x: fbShareCenterX, y: height-170, width: shareButtonImage.size.width, height: shareButtonImage.size.height)
        facebookButton.setBackgroundImage(shareButtonImage, for: UIControl.State.normal)
        facebookButton.setTitle(share_on_fb_string, for: UIControl.State.normal)
        facebookButton.tintColor = UIColor.white
        facebookButton.addTarget(self, action: #selector(shareOnFacebook(_:)), for: UIControl.Event.touchUpInside)
        facebookButton.titleLabel?.font = UIFont(name: "Vibur", size: 33)
        
        
        
        
        // FEEDBACK BUTTON
        
        let sentTipsButtonImage = UIImage(named: "feedback-cloud")!
        sentTipsButton.frame = CGRect(x: width-170, y: height/2-60, width: sentTipsButtonImage.size.width, height: sentTipsButtonImage.size.height)
        sentTipsButton.setBackgroundImage(sentTipsButtonImage, for: UIControl.State.normal)
        sentTipsButton.addTarget(self, action: #selector(sendEmail(_:)), for: UIControl.Event.touchUpInside)
        
        
        // FEEDBACK BUTTON - INSIDE
        
        feedbackCloud1 = UILabel(frame: CGRect(x: width-140, y: height/2-45, width: sentTipsButton.frame.width, height: 30))
        feedbackCloud1.text = send_feedback_string_1
        feedbackCloud1.font = UIFont(name: "Vibur", size: 24)
        feedbackCloud1.textColor = UIColor(named: "#4273B9")
        view.addSubview(feedbackCloud1)
        feedbackCloud2 = UILabel(frame: CGRect(x: width-150, y: height/2-20, width: sentTipsButton.frame.width, height: 30))
        feedbackCloud2.text = send_feedback_string_2
        feedbackCloud2.font = UIFont(name: "Vibur", size: 21)
        feedbackCloud2.textColor = UIColor(named: "#4273B9")
        view.addSubview(feedbackCloud2)
        
        
        
        let isSharedOnFB = userDefaults.bool(forKey: defaultsKeys.isSharedOnFacebook)

        if(!isSharedOnFB) {
            gain_the_assistant = UILabel(frame: CGRect(x: width/2 - 150, y: height-100, width: 380, height: 45))
            gain_the_assistant.text = "..." + gain_assistant_string
            gain_the_assistant.font = UIFont(name: "Vibur", size: 34)
            gain_the_assistant.textColor = UIColor(named: "#21326E")
            view.addSubview(gain_the_assistant)
        }
        
        self.view!.addSubview(facebookButton)
        self.view!.addSubview(sentTipsButton)
        
        /* FACEBOOK LOGIN
        let loginButton: FBSDKLoginButton = FBSDKLoginButton()
        loginButton.center = self.view!.center
        self.view!.addSubview(loginButton)*/
   
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    
    @objc func play(_ sender: UIButton!) {
        mixpanel.track(event: "Play button clicked")
        let defaults = UserDefaults.standard
        defaults.set(true, forKey: defaultsKeys.isStarted)
        
        defaults.synchronize()
        
        removeObjectsFromSubview()
        
        presentNextLevel()
        
//        let level: SKScene = Level1(size: self.size)
//        level.scaleMode = scaleMode
//        let transition = SKTransition.fade(withDuration: 1)
//        view!.presentScene(level, transition: transition)
    }
    
    
    
    
    // RESUME
    @objc func resume(_ sender: UIButton!) {
        
        mixpanel.track(event: "Resume button clicked")
        
        
        removeObjectsFromSubview()
        presentNextLevel()
    }
    
    
    
    @objc func restart(_ sender: UIButton!) {
        mixpanel.track(event: "Restart button clicked")
        
        userDefaults.set(1, forKey: defaultsKeys.level)
        userDefaults.set(1, forKey: defaultsKeys.complexity)
        userDefaults.set(false, forKey: defaultsKeys.isStarted)
        userDefaults.synchronize()
        
        
        playButton.removeFromSuperview()
        restartButton.removeFromSuperview()
        continueButton.removeFromSuperview()
        
        self.view!.addSubview(playButton)
    }
    
    
    @objc func sendEmail(_ sender: UIButton!) {
        let controller = self.view?.window?.rootViewController as! GameViewController

        gateParental(
            ifSuccess: { () -> Void in
                self.mixpanel.track(event: "Send feedback button clicked")
                controller.sendEmailButtonTapped()
            },
            ifFail: { () -> Void in
                self.mixpanel.track(event: "Fail on the parental control (send email)")
            }
        )
    }
    
    
    // SHARE ON FACEBOOK
    @objc func shareOnFacebook(_ sender: UIButton!) {
        let controller = self.view?.window?.rootViewController as! GameViewController

        gateParental(
            ifSuccess: { () -> Void in
                self.mixpanel.track(event: "Share on facebook button clicked")
                self.showShareDialog()
            },
            ifFail: { () -> Void in
                self.mixpanel.track(event: "Fail on the parental control (share on facebook)")
            }
        )
    }
    
    
    func gateParental(ifSuccess: @escaping () -> Void, ifFail: @escaping () -> Void)  {
        let controller = self.view?.window?.rootViewController as! GameViewController

        let firstNum = Int(arc4random_uniform(UInt32(4)))
        let secondNum = Int(arc4random_uniform(UInt32(4)))
        let thirdNum = Int(arc4random_uniform(UInt32(4)))
        
        let result = firstNum * secondNum + thirdNum
        let operation2String = String(firstNum) + " x " + String(secondNum) + " + " + String(thirdNum) + " ="
        
        
        let alert = UIAlertController(title: parental_control_string, message: operation2String, preferredStyle: .alert)

        
        
        alert.addTextField(configurationHandler: { (textField) -> Void in
            textField.placeholder = self.enter_result_string
            textField.keyboardType = UIKeyboardType.decimalPad
        })
        
        print("result must be:")
        print(result)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default) { action in
            let textField = alert.textFields![0] as UITextField
            if(textField.text == String(result)) {
                ifSuccess()
            }
            else {
                ifFail()
            }
        })
        
        
        controller.present(alert, animated: true, completion: nil)
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
        let isSharedOnFB = userDefaults.bool(forKey: defaultsKeys.isSharedOnFacebook)
        if(!isSharedOnFB) {
            gain_the_assistant.removeFromSuperview()
        }
    }
    
    
    
    
    // FACEBOOK ----------------
    func showShareDialog(){
        let controller = self.view?.window?.rootViewController as! GameViewController
        let content = ShareLinkContent()
        
        content.contentURL = URL(string: website_url_string)!
        
        let dialog = ShareDialog(
            fromViewController: controller,
            content: content,
            delegate: self
        )
        dialog.show()
    }


    func sharer(_ sharer: Sharing, didCompleteWithResults results: [String : Any]) {
        print("condiviso")
        userDefaults.set(true, forKey: defaultsKeys.isSharedOnFacebook)
        mixpanel.track(event: "Shared on Facebook")
//        if let scene = GameScene(fileNamed:"GameScene") {
//            // Configure the view.
//            let skView = self.view as! SKView
//            /* Sprite Kit applies additional optimizations to improve rendering performance */
//            skView.ignoresSiblingOrder = true
//            /* Set the scale mode to scale to fit the window */
//            scene.scaleMode = .aspectFill
//            skView.presentScene(scene)
//        }
        print(results)
    }

    func sharer(_ sharer: Sharing, didFailWithError error: Error) {
        print("sharer NSError")
        print(error.localizedDescription)
        mixpanel.track(event: "Share error")
    }
    
    func sharerDidCancel(_ sharer: Sharing) {
        print("")
        print("")
        print("")
        print("sharerDidCancel")
        mixpanel.track(event: "Share cancelled")
        print("")
        print("")
        print("")
    }
    

//    func loginButton(loginButton: LoginButton!, didCompleteWithResult result: LoginManagerLoginResult!, error: NSError!) {
//        print("User Logged In")
//        /*if ((error) != nil)
//        {
//            // Process error
//        }
//        else if result.isCancelled {
//            // Handle cancellations
//        }
//        else {
//            // If you ask for multiple permissions at once, you
//            // should check if specific permissions missing
//            if result.grantedPermissions.contains("email")
//            {
//                // Do work
//            }
//        }*/
//    }
//
//    func loginButtonDidLogOut(loginButton: LoginButton!) {
//        print("User Logged Out")
//    }


    // ||| FACEBOOK ----------------
}


