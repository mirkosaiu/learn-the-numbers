//
//  CheckTrack.swift
//  Tuco2
//
//  Created by Mirko Saiu on 15/02/15.
//  Copyright (c) 2015 Mirko Saiu. All rights reserved.
//

import Foundation
import SpriteKit
import AVFoundation

class CheckTrack: SKSpriteNode {
    var id = 0
    var next = 0
    var checked = false
    var audioCheckTrackOn = AVAudioPlayer()
    
    
    

    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        
        let texture = SKTexture(imageNamed: "check_track_red")
        super.init(texture: texture, color: UIColor(), size: texture.size())
        
        
        audioCheckTrackOn = setupAudioPlayerWithFile("notifica1", type:"mp3")
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func becomeGreen() {
        self.texture = SKTexture(imageNamed: "check_track_green")
    }
    func on() {
        removeActionForKey("initial_ct_anim")
        let action1 = SKAction.scaleTo(1.2, duration: 0.1)
        let action2 = SKAction.scaleTo(1.0, duration: 0.3)
        let sequence = SKAction.sequence([action1,action2])
        runAction(sequence)
        
        audioCheckTrackOn.play()
        
        self.texture = SKTexture(imageNamed: "check_track_green")
        checked = true
    }
    func off() {
        self.texture = SKTexture(imageNamed: "check_track_red")
        checked = false
        
        let action1 = SKAction.scaleTo(1.2, duration: 0.1)
        let action2 = SKAction.scaleTo(1.0, duration: 0.3)
        let sequence = SKAction.sequence([action1,action2])
        runAction(sequence)
    }
    
    func setupAudioPlayerWithFile(file: String, type: String) -> AVAudioPlayer  {
        // the full path to the resources
        let path = NSBundle.mainBundle().pathForResource(file, ofType: type)
        let url = NSURL.fileURLWithPath(path!)
        var error: NSError?
        var audioPlayer:AVAudioPlayer?
        do {
            audioPlayer = try AVAudioPlayer(contentsOfURL: url)
        } catch let error1 as NSError {
            error = error1
            audioPlayer = nil
        }
        return audioPlayer!
    }
    
    func startLoop() {
        // MOVEMENT WHO CATCHES THE ATTENTION
        let zoomIn = SKAction.scaleTo(1.3, duration: 0.6)
        let zoomOut = SKAction.scaleTo(1.0, duration: 0.8)
        let delay2 = SKAction.waitForDuration(NSTimeInterval(0.5))
        let sequence = SKAction.sequence([delay2, zoomIn, zoomOut])
        let loop = SKAction.repeatActionForever(sequence)
        runAction(loop, withKey: "initial_ct_anim")
        runAction(loop)
        
        self.texture = SKTexture(imageNamed: "check_track_blue")
    }
    
}