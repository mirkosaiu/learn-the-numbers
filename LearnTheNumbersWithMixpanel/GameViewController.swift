//
//  GameViewController.swift
//  Learn the Numbers
//
//  Created by Mirko Saiu on 05/07/15.
//  Copyright (c) 2015 Mirko Saiu. All rights reserved.
//

import UIKit
import SpriteKit
import Social
import FBSDKCoreKit
import FBSDKShareKit
import FBSDKLoginKit
import Mixpanel

import MessageUI


//WHEN ADD AN ELEMENT, INITIALIZE IT IN APPDELEGATE
struct defaultsKeys {
    static let hasLaunchedOnce = "hasLaunchedOnce"
    static let isfirstPlay = "isfirstPlay"
    static let isSharedOnFacebook = "isSharedOnFacebook"
    static let level = "level"
    static let complexity = "complexity"
}

let userDefaults = NSUserDefaults.standardUserDefaults()
let mixpanleToken = "cb96522d13466a930b354aae2038b8dd"


class GameViewController: UIViewController, FBSDKSharingDelegate, MFMailComposeViewControllerDelegate {
    var mixpanel: Mixpanel = Mixpanel.sharedInstanceWithToken(mixpanleToken)

    let facebookButton = UIButton(type: UIButtonType.System)
    
    let website_url_string = NSLocalizedString("WEBSITE_URL", comment: "")
    
    
    // FACEBOOK ----------------
    func showShareDialog(){
        let content: FBSDKShareLinkContent = FBSDKShareLinkContent()
        content.contentURL = NSURL(string: website_url_string)
        FBSDKShareDialog.showFromViewController(self, withContent: content, delegate: self)
    }
    
    
    func sharer(sharer: FBSDKSharing!, didCompleteWithResults results: [NSObject: AnyObject]) {
        userDefaults.setBool(true, forKey: defaultsKeys.isSharedOnFacebook)
        mixpanel.track("Shared on Facebook")
        if let scene = GameScene(fileNamed:"GameScene") {
            // Configure the view.
            let skView = self.view as! SKView
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .AspectFill
            skView.presentScene(scene)
        }
        print(results)
    }
    
    func sharer(sharer: FBSDKSharing!, didFailWithError error: NSError!) {
        print("sharer NSError")
        print(error.description)
        mixpanel.track("Share error")
    }
    
    func sharerDidCancel(sharer: FBSDKSharing!) {
        print("")
        print("")
        print("")
        print("sharerDidCancel")
        mixpanel.track("Share cancelled")
        print("")
        print("")
        print("")
    }
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        print("User Logged In")
        /*if ((error) != nil)
        {
            // Process error
        }
        else if result.isCancelled {
            // Handle cancellations
        }
        else {
            // If you ask for multiple permissions at once, you
            // should check if specific permissions missing
            if result.grantedPermissions.contains("email")
            {
                // Do work
            }
        }*/
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        print("User Logged Out")
    }
    
    
    // ||| FACEBOOK ----------------
    
    
    
    

    
    
    
    
    
    
    
    
    
    
    
    // MAIL --------------------
    func sendEmailButtonTapped() {
        let mailComposeViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail() {
            self.presentViewController(mailComposeViewController, animated: true, completion: nil)
        } else {
            self.showSendMailErrorAlert()
        }
    }
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self // Extremely important to set the --mailComposeDelegate-- property, NOT the --delegate-- property
        let object_string = NSLocalizedString("EMAIL_OBJECT", comment: "")
        let body_string = NSLocalizedString("EMAIL_BODY", comment: "")
        mailComposerVC.setToRecipients(["mirko.saiu@gmail.com"])
        mailComposerVC.setSubject(object_string)
        mailComposerVC.setMessageBody(body_string, isHTML: false)
        
        return mailComposerVC
    }
    func showSendMailErrorAlert() {
        let sendMailErrorAlert = UIAlertView(title: "Could Not Send Email", message: "Your device could not send e-mail.  Please check e-mail configuration and try again.", delegate: self, cancelButtonTitle: "OK")
        sendMailErrorAlert.show()
    }
    // MARK: MFMailComposeViewControllerDelegate Method
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
    // ||| MAIL --------------------
    
    
    
    
    
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if let scene = GameScene(fileNamed:"GameScene") {
            // Configure the view.
            let skView = self.view as! SKView
            /*
            skView.showsFPS = true
            skView.showsNodeCount = true
            */
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true
            
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .AspectFill
            
            skView.presentScene(scene)
        }
    }
    
    override func shouldAutorotate() -> Bool {
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
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
 
}
