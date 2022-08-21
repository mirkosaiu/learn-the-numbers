//
//  Level3.swift
//
//
//  Created by Mirko Saiu on 05/07/15.
//
//


import Foundation
import SpriteKit
import AVFoundation

class Level3: SKSceneSuper {
    
    var from = 0
    var to = 2
    
    let level = userDefaults.integer(forKey: defaultsKeys.level)
    let complexity: Int = userDefaults.integer(forKey: defaultsKeys.complexity)
    
    var fingerLocation: CGPoint = CGPoint()
    var audioInTheHole = AVAudioPlayer()
    
    var numberList = [Number]()
    var holeList = [SKSpriteNode]()
    var holeOKList = [SKSpriteNode]()
    
    var scores = 0
    var scoresToCompleteThisLevel = 0
    var hasBeenPerformedOnce = false
    
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        mixpanel.track(event: "Level start",  properties: ["Level": String(level), "Complexity": String(complexity)])

        
        scoresToCompleteThisLevel = complexity*3
        
        setBaseEnvironment()
        setBackgroundSong()
        setReturnButton()
        setElica()
        initHoles()
        initNumbers()
        
        showHoles(from: 0,to: 2)
        
        // PUTS THE NUMBERS ON THE SCENE
        for number in numberList {
            super.addChild(number)
        }
        
        
        
        
        // PUTS THE HOLES ON THE SCENE
        for hole in holeList {
            addChild(hole)
        }
        
        
        
        // SETTING THE GRAVITY LIKE IN REAL WORLD
        self.physicsWorld.gravity = CGVector(dx: 0, dy: -1)
        
        
        
        // IN ORDER TO DON'T LET GO AWAY THE PHISICS OBJECT INSIDE THE SCENE. THEY WILL JUST BOUNCE AWAY
        let sceneBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        sceneBody.friction = 0
        self.physicsBody = sceneBody
        
        audioInTheHole = setupAudioPlayerWithFile(file: "notifica1", type:"mp3")
    }
    
    
    // CREATES NUMBERS
    func initNumbers() {
        for i in 1...(complexity*3) {
            var number: Number
            switch i {
            case 1:
                number = Number(theNumber: .One)
                numberList.append(number)
            case 2:
                number = Number(theNumber: .Two)
                numberList.append(number)
            case 3:
                number = Number(theNumber: .Three)
                numberList.append(number)
            case 4:
                number = Number(theNumber: .Four)
                numberList.append(number)
            case 5:
                number = Number(theNumber: .Five)
                numberList.append(number)
            case 6:
                number = Number(theNumber: .Six)
                numberList.append(number)
            case 7:
                number = Number(theNumber: .Seven)
                numberList.append(number)
            case 8:
                number = Number(theNumber: .Eight)
                numberList.append(number)
            case 9:
                number = Number(theNumber: .Nine)
                numberList.append(number)
            default:
                number = Number(theNumber: .One)
                numberList.append(number)
            }
        }
        
        for number in numberList {
            number.zPosition = 30
            
            number.isUserInteractionEnabled = true
            number.physicsBody = SKPhysicsBody(texture: number.texture!, size: number.size)
            number.physicsBody?.isDynamic = true
            
            // THE NODE WILL BE AFFECTED BY THE GRAVITY SETTED IN THE SCENE
            number.physicsBody?.affectedByGravity = true
            // TO CONTROL THE BOUNCING. IF SETTED TO 1, THE NODE WILL RETURN AT THE STARTING POSITION
            number.physicsBody?.restitution = 1.02
            // SETTING THE AIR RESISTANCE
            number.physicsBody?.linearDamping = 0
            
            
            
            //physicsBody?.allowsRotation = true
            
            
            //physicsBody = SKPhysicsBody(texture: textureNumber, size: size)
        }
        
        columnizeSpriteList(columns: 3, items: numberList)
    }
    
    // CREATES HOLES
    func initHoles() {
        for i in 1...(complexity*3) {
            switch i {
            case 1:
                let hole = SKSpriteNode(imageNamed: "hole_one")
                let holeOK = SKSpriteNode(imageNamed: "hole_one_ok")
                holeList.append(hole)
                holeOKList.append(holeOK)
            case 2:
                let hole = SKSpriteNode(imageNamed: "hole_two")
                let holeOK = SKSpriteNode(imageNamed: "hole_two_ok")
                holeList.append(hole)
                holeOKList.append(holeOK)
            case 3:
                let hole = SKSpriteNode(imageNamed: "3_hole")
                let holeOK = SKSpriteNode(imageNamed: "3_hole_ok")
                holeList.append(hole)
                holeOKList.append(holeOK)
            case 4:
                let hole = SKSpriteNode(imageNamed: "4_hole")
                let holeOK = SKSpriteNode(imageNamed: "4_hole_ok")
                holeList.append(hole)
                holeOKList.append(holeOK)
            case 5:
                let hole = SKSpriteNode(imageNamed: "5_hole")
                let holeOK = SKSpriteNode(imageNamed: "5_hole_ok")
                holeList.append(hole)
                holeOKList.append(holeOK)
            case 6:
                let hole = SKSpriteNode(imageNamed: "6_hole")
                let holeOK = SKSpriteNode(imageNamed: "6_hole_ok")
                holeList.append(hole)
                holeOKList.append(holeOK)
            case 7:
                let hole = SKSpriteNode(imageNamed: "7_hole")
                let holeOK = SKSpriteNode(imageNamed: "7_hole_ok")
                holeList.append(hole)
                holeOKList.append(holeOK)
            case 8:
                let hole = SKSpriteNode(imageNamed: "8_hole")
                let holeOK = SKSpriteNode(imageNamed: "8_hole_ok")
                holeList.append(hole)
                holeOKList.append(holeOK)
            case 9:
                let hole = SKSpriteNode(imageNamed: "9_hole")
                let holeOK = SKSpriteNode(imageNamed: "9_hole_ok")
                holeList.append(hole)
                holeOKList.append(holeOK)
            default:
                let hole = SKSpriteNode(imageNamed: "hole_one")
                let holeOK = SKSpriteNode(imageNamed: "hole_one_ok")
                holeList.append(hole)
                holeOKList.append(holeOK)
            }
            
            for hole in holeList{
                hole.zPosition = 2
            }
            for holeOK in holeOKList{
                holeOK.zPosition = 2
            }
        }
        
        
        
        columnizeSpriteList(columns: 3, items: holeList, height: height+100)
    }
    

    
    
    
    
    
    
    
    func showHoles(from: Int, to: Int) {
        for i in from...to {
            let action = SKAction.move(to: CGPoint(x: holeList[i].position.x, y: holeList[i].position.y-210), duration: 1)
            holeList[i].run(action)
            holeOKList[i].run(action)
        }
    }
    
    
    
    func hideHoles(from: Int, to: Int) {
        for i in from...to {
            let action = SKAction.move(to: CGPoint(x: holeList[i].position.x, y: holeList[i].position.y+210), duration: 1)
            holeList[i].run(action)
            holeOKList[i].run(action)
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    // UPDATE
    override func update(_ currentTime: TimeInterval) {
        let tolleranza = CGFloat(30)

        if(scores != scoresToCompleteThisLevel){
            for i in from...to {
                let number = numberList[i]
                let hole = holeList[i]
                
                if (!number.inTheHole
                    && !number.isDynamic
                    && number.position.x < hole.position.x+tolleranza
                    && number.position.x > hole.position.x-tolleranza
                    && number.position.y < hole.position.y+tolleranza
                    && number.position.y > hole.position.y-tolleranza
                    )
                {
                    number.inTheHole = true
                    let actionFade = SKAction.fadeAlpha(to: CGFloat(0), duration: 1.5)
                    let actionScale = SKAction.scale(to: CGFloat(2), duration: 1.5)
                    let actionGoAway = SKAction.move(to: CGPoint(x: 0.0, y: -size.height), duration: 0.1)
                    
                    number.run(actionScale)
                    number.run(SKAction.sequence([actionFade, actionGoAway]))
                    hole.texture = holeOKList[i].texture
                    audioInTheHole.play()
                    
                    scores += 1
                    
                    
                    sayThis(string: String(number.numberInt))
                    
                    if(scores % 3 == 0 && scores != scoresToCompleteThisLevel) {
                        hideHoles(from: from, to: to)
                        from = scores
                        to = scores+2
                        showHoles(from: from, to: to)
                    }
                }
            }
        } else {
            if(!hasBeenPerformedOnce){
                hasBeenPerformedOnce = true
                nextLevel()
            }
        }

    }
}











