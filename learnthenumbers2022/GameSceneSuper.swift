//
//  GameSceneSuper.swift
//  learnthenumbers2022
//
//  Created by Mirko Saiu on 19/08/22.
//


import Foundation
import AVFoundation
import SpriteKit

import Mixpanel


class SKSceneSuper: SKScene {
    let mixpanel = Mixpanel.initialize(token: mixpanelToken, trackAutomaticEvents: false)

    
    var actualLanguage = NSLocalizedString("ACTUAL_LANGUAGE", comment: "")
    var width: CGFloat = 0.0
    var height: CGFloat = 0.0
    
    
    // SPEECH VOICE
    let synth = AVSpeechSynthesizer()
    var myUtterance = AVSpeechUtterance()
    
    // RETURN MENU VARS
    let labelCount = UILabel(frame: CGRect(x: 100, y: 40, width: 40, height: 40))
    var count = 3
    var isTouchCancelled = false
    var returnButton: UIButton!
    var timer: Timer!
    
    
    let level_complete_string = NSLocalizedString("LEVEL_COMPLETE", comment: "")
    
    var audio = AVAudioPlayer()
    var badgeText = UILabel()
    
    
    override func didMove(to view: SKView) {

        anchorPoint = CGPoint(x: 0, y: 0)
        height = self.size.height
        width = self.size.width
        //view.showsPhysics = true
    }
    
    
    
    // THE BACKGROUND
    func setBackground () {
        let bgSprite = SKSpriteNode(imageNamed: "bg_sky")
        bgSprite.zPosition = -1
        bgSprite.position = CGPoint(x: frame.midX, y: frame.midY)
        bgSprite.size = self.size
        addChild(bgSprite)
    }
    

    func setBackgroundSong() {
        audio = setupAudioPlayerWithFile(file: "piano-bells-happiness", type:"mp3")
        audio.volume = 0
        audio.numberOfLoops = -1
        audio.play()
    }
    
    
    // THE FRUITS BACKGROUND
    func setFruitsBackground () {
        let bgSprite = SKSpriteNode(imageNamed: "bg_fruits")
        bgSprite.zPosition = 0
        bgSprite.anchorPoint = CGPoint(x: 0, y: 0)
        addChild(bgSprite)
    }
    
    // THE CLOUDS
    func setClouds () {
        let clouds = SKSpriteNode(imageNamed: "clouds")
        clouds.zPosition = 1
        clouds.position = CGPoint(x: 180, y: height-80)
        addChild(clouds)
        let actionMoveToRight = SKAction.move(to: CGPoint(x: width-180, y: clouds.position.y), duration: 12)
        let actionMoveToLeft = SKAction.move(to: CGPoint(x: 180, y: clouds.position.y), duration: 12)
        let actionSeq = SKAction.sequence([actionMoveToRight, actionMoveToLeft])
        clouds.run(SKAction.repeatForever(actionSeq))
    }
    
    
    // THE GRASS
    func setGrass () {
        let grass = SKSpriteNode(imageNamed: "grass")
        grass.zPosition = 1
        grass.anchorPoint = CGPoint(x: 0, y: 0)
        grass.position = CGPoint(x: 0, y: 0)
        grass.size.width = self.width
        addChild(grass)
    }
    
    // RETURN BUTTON
    func setReturnButton() {
        let returnImage = UIImage(named: "return-menu")!
        returnButton = UIButton(type: UIButton.ButtonType.system)
        returnButton.frame = CGRect(x: 30, y: 30, width: returnImage.size.width, height: returnImage.size.height)
        returnButton.setBackgroundImage(returnImage, for: UIControl.State.normal)
        
        returnButton.addTarget(self, action: #selector(returnToMenuTouchDown(_:)), for: UIControl.Event.touchDown)
        returnButton.addTarget(self, action: #selector(returnToMenuTouchCancel(_:)), for: UIControl.Event.touchUpInside)
        
        self.view!.addSubview(returnButton)
        
        labelCount.textColor = UIColor.white
        labelCount.font = UIFont(name: "Vibur", size: 27)
        self.view!.addSubview(labelCount)
        
    }
    
    
    @objc func returnToMenuTouchDown(_ sender: UIButton!) {
        labelCount.text = "3"
        isTouchCancelled = false
        timer = Timer.scheduledTimer(timeInterval: 0.7, target: self, selector: #selector(updateCount), userInfo: nil, repeats: true)
    }
    
    @objc func returnToMenuTouchCancel(_ sender: UIButton!) {
        isTouchCancelled = true
        count = 3
        
        labelCount.text = ""
        timer.invalidate()
    }
    
    
    @objc func updateCount() {
        if(count > 0 && !isTouchCancelled) {
            count -= 1
            labelCount.text = String(count)
        }
        else if (count > 0 && isTouchCancelled) {
            labelCount.text = ""
        }
        else {
            timer.invalidate()
            labelCount.removeFromSuperview()
            returnButton.removeFromSuperview()
            let menu = GameScene(size: self.size)
            menu.scaleMode = scaleMode
            let transition = SKTransition.fade(withDuration: 0)
            view!.presentScene(menu, transition: transition)
        }
    }
    // _______________________________#####
    
    
    func setBaseEnvironment () {
        setBackground()
        setClouds()
        setGrass()
        setAssistant()
    }
    
    
    func setAssistant() {
        let isSharedOnFB = userDefaults.bool(forKey: defaultsKeys.isSharedOnFacebook)
        print("isSharedOnFB")
        print(isSharedOnFB)
        
        if(isSharedOnFB){
            let lion = SKSpriteNode(imageNamed: "lion")
            lion.zPosition = 2
            lion.position = CGPoint(x: width-180, y: 180)
            /*
            lion.userInteractionEnabled = false
            lion.physicsBody = SKPhysicsBody(texture: lion.texture!, size: lion.texture!.size())
            lion.physicsBody?.dynamic = false*/
            addChild(lion)
        }
    }
    
    
    
    // ELICA
    func setElica () {
        let elicaTexture = SKTexture(imageNamed: "elica")
        let elica = SKSpriteNode(texture: elicaTexture)
        elica.physicsBody = SKPhysicsBody(texture: elicaTexture, size: elica.size)
        elica.physicsBody?.isDynamic = false
        elica.physicsBody?.affectedByGravity = false
        elica.position = CGPoint(x: size.width/2, y: size.height/2)
        elica.zPosition = 1
        addChild(elica)
        let rotation = SKAction.rotate(byAngle: CGFloat(-Double.pi), duration: 4)
        elica.run(SKAction.repeatForever(rotation))
    }
    
    
    
    
    
    
    func columnizeSpriteList(columns: Int, items: [SKSpriteNode], height: CGFloat) {
        var row = CGFloat(0)
        var column = CGFloat(0)
        let positionY = height
        
        for i in 0...(items.count-1) {
            column = column + 1
            if( i %  columns == 0) {
                if(i != 0) {
                    row = CGFloat(row+1)
                }
                column = 0
                //positionY =  CGFloat(height-160*row)-120
            }
            let item = items[i]
            let positionX = width/CGFloat(columns+1) * CGFloat(column+1)
            item.position = CGPoint(x: positionX, y: positionY)
        }
    }
    
    
    func columnizeSpriteList(columns: Int, items: [SKSpriteNode]) {
        var row = CGFloat(0)
        var column = CGFloat(0)
        var positionY = CGFloat(height-120)
        
        for i in 0...(items.count-1) {
            column = column + 1
            if( i %  columns == 0) {
                if(i != 0) {
                    row = CGFloat(row+1)
                }
                column = 0
                positionY =  CGFloat(height-160*row)-120
            }
            let item = items[i]
            let positionX = width/CGFloat(columns+1) * CGFloat(column+1)
            item.position = CGPoint(x: positionX, y: positionY)
        }
    }
    
    
    
    func nextLevel() {
        // UPDATES LEVEL AND COMPLEXITY
        let level = userDefaults.integer(forKey: defaultsKeys.level) + 1
        userDefaults.set(level, forKey: defaultsKeys.level)
        if(level > 1 && (level-1) % 3 == 0) {
            let complexity = userDefaults.integer(forKey: defaultsKeys.complexity) + 1
            userDefaults.set(complexity, forKey: defaultsKeys.complexity)
        }
        userDefaults.synchronize()
        
        Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(showScreenBetween2Levels), userInfo: nil, repeats: false)
    }
    
    
    @objc func showScreenBetween2Levels(){
        let badgeBetweenLevels = SKSpriteNode(imageNamed: "badge-between-levels")
        badgeBetweenLevels.position = CGPoint(x: width/2, y: height/2+100)
        badgeBetweenLevels.zPosition = 100
        addChild(badgeBetweenLevels)
        
        returnButton.removeFromSuperview()

        audio = setupAudioPlayerWithFile(file: "level-completed", type:"mp3")
        audio.play()
        
        badgeText = UILabel(frame: CGRect(x: width/2-60, y: height/2-150, width: 500, height: 100))
        badgeText.font = UIFont(name: "Vibur", size: 45)
        badgeText.textColor = UIColor(named: "#FF7300")
        badgeText.text = level_complete_string + "!"
        self.view?.addSubview(badgeText)
        
        
        Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(presentNextLevel), userInfo: nil, repeats: false)
    }
    
    
    @objc func presentNextLevel(){
        let level = userDefaults.integer(forKey: defaultsKeys.level)
        print("level")
        print(level)
        
        // IF THE GAME HAS FINISHED
        if(level > 9){
            userDefaults.set(1, forKey: defaultsKeys.level)
            userDefaults.set(1, forKey: defaultsKeys.complexity)
            userDefaults.set(true, forKey: defaultsKeys.isStarted)
            userDefaults.synchronize()
            mixpanel.track(event: "Game finished")
        }
        
        var level2show: SKScene = SKScene()
        
        switch(level) {
        case 1: level2show = Level1(size: self.size)
        case 4: level2show = Level1(size: self.size)
        case 7: level2show = Level1(size: self.size)
        case 2: level2show = Level3(size: self.size)
        case 5: level2show = Level3(size: self.size)
        case 8: level2show = Level3(size: self.size)
        case 3: level2show = Level4(size: self.size)
        case 6: level2show = Level4(size: self.size)
        case 9: level2show = Level4(size: self.size)
        default: level2show = GameScene(size: self.size)
        }
        
        badgeText.removeFromSuperview()
        
        level2show.scaleMode = scaleMode
        let transition = SKTransition.fade(withDuration: 0)
        view!.presentScene(level2show, transition: transition)
    }
    
    
    
    
    
    
    
    
    
    // AUDIO
    func setupAudioPlayerWithFile(file: String, type: String) -> AVAudioPlayer  {
        // the full path to the resources
        let path = Bundle.main.path(forResource: file, ofType: type)
        let url = NSURL.fileURL(withPath: path!)
        var error: NSError?
        var audioPlayer:AVAudioPlayer?
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
        } catch let error1 as NSError {
            error = error1
            audioPlayer = nil
        }
        return audioPlayer!
    }
    
   
    func sayThis(string: String) {
        // SAYS THE NAME OF THE NUMBER
        myUtterance = AVSpeechUtterance(string: string)
        myUtterance.rate = -1.0
        myUtterance.voice = AVSpeechSynthesisVoice(language: actualLanguage)
        synth.speak(myUtterance)
    }
    
    
    

    
}

