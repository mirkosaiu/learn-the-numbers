//
//  GameViewController.swift
//  learnthenumbers2022
//
//  Created by Mirko Saiu on 19/08/22.
//

import UIKit
import SpriteKit
import GameplayKit




import MessageUI

//WHEN ADD AN ELEMENT, INITIALIZE IT IN APPDELEGATE
struct defaultsKeys {
    static let hasLaunchedOnce = "hasLaunchedOnce"
    static let isStarted = "isStarted"
    static let isSharedOnFacebook = "isSharedOnFacebook"
    static let level = "level"
    static let complexity = "complexity"
}
let userDefaults = UserDefaults.standard

class GameViewController: UIViewController, MFMailComposeViewControllerDelegate {

    
    let facebookButton = UIButton(type: UIButton.ButtonType.system)

    let website_url_string = NSLocalizedString("WEBSITE_URL", comment: "")


    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(userDefaults.bool(forKey: defaultsKeys.isStarted) == false) {
            userDefaults.set(1, forKey: defaultsKeys.level)
            userDefaults.set(1, forKey: defaultsKeys.complexity)
        }
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .resizeFill
                
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = false
            view.showsNodeCount = false
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
    
    
    
    
    
    
    
    
    
    
    // MAIL --------------------
    func sendEmailButtonTapped() {
        let mailComposeViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail() {
            self.present(mailComposeViewController, animated: true, completion: nil)
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
        controller.dismiss(animated: true, completion: nil)
    }
    // ||| MAIL --------------------
    
    
    
    



    

    
}
