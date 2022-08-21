//
//  Level1.swift
//  Learn the Numbers
//
//  Created by Mirko Saiu on 05/07/15.
//  Copyright (c) 2015 Mirko Saiu. All rights reserved.
//

import Foundation
import AVFoundation
import SpriteKit
import Mixpanel

class Level1: SKSceneSuper{
    
    var from = 0
    var to = 2
    
    // LEVEL AND SCORES
    let level = userDefaults.integer(forKey: defaultsKeys.level)
    let complexity: Int = userDefaults.integer(forKey: defaultsKeys.complexity)
    let scoreToCompleteThisLevel = 3 * userDefaults.integer(forKey: defaultsKeys.complexity)
    var scores: Int = 0
    
    // USED TO EXUCTE JUST ONCE THE CODE TO PRESENT THE NEW LEVEL
    var didOnce = false
    
    
    // MIXPANEL
    var countNumber: Number = Number(theNumber: NumberName.One)
    
    
    // SPRITE NODES
    let glass = SKSpriteNode(imageNamed: "glass")
    let boxArrow = SKSpriteNode(imageNamed: "dotted-box")
    let arrow = SKSpriteNode(imageNamed: "down-arrow")
    
    var fruitList = [Fruit]()
    var fruitsIntoTheChest = [Fruit]()
    
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
                
        mixpanel.track(event: "Level start",  properties: ["Level": String(level), "Complexity": String(complexity)])
        
        
        setBaseEnvironment()
        setBackgroundSong()
        setReturnButton()
        
        // GLASS
        glass.position = CGPoint(x: size.width/2 - glass.size.width/2, y: 20)
        glass.zPosition = 19
        
        glass.anchorPoint = CGPoint(x: 0, y: 0)
        addChild(glass)
        
        
        
        let path: CGMutablePath = CGMutablePath()
        let offsetX: CGFloat = 0
        let offsetY: CGFloat = 0
        
        path.move(to: CGPoint(x: 4 - offsetX, y: 209 - offsetY))
        path.addLine(to: CGPoint(x: 4 - offsetX, y: 209 - offsetY))
        path.addLine(to: CGPoint(x: 49 - offsetX, y: 16 - offsetY))
        path.addLine(to: CGPoint(x: 247 - offsetX, y: 17 - offsetY))
        path.addLine(to: CGPoint(x: 307 - offsetX, y: 209 - offsetY))
        path.addLine(to: CGPoint(x: 302 - offsetX, y: 209 - offsetY))
        path.addLine(to: CGPoint(x: 245 - offsetX, y: 20 - offsetY))
        path.addLine(to: CGPoint(x: 52 - offsetX, y: 19 - offsetY))
        path.addLine(to: CGPoint(x: 7 - offsetX, y: 208 - offsetY))
        path.closeSubpath()
        
        
        glass.physicsBody = SKPhysicsBody(polygonFrom: path)
        glass.physicsBody?.isDynamic = false
        glass.physicsBody?.affectedByGravity = false
        
        
        
        
        
        
        
        
        
        
        // BOX ARROW
        boxArrow.position = CGPoint(x: size.width/2, y: height/2)
        boxArrow.zPosition = 19
        addChild(boxArrow)
        
        
        // ARROW
        arrow.position = CGPoint(x: size.width/2, y: height/2+10)
        arrow.zPosition = 19
        
        
        // UP AND DOWN ARROW ACTION
        let downArrowAction = SKAction.move(to: CGPoint(x: arrow.position.x, y: arrow.position.y-20.0), duration: 1)
        let upArrowAction = SKAction.move(to: CGPoint(x: arrow.position.x, y: arrow.position.y), duration: 1)
        let upDownArrowSequence = SKAction.sequence([downArrowAction, upArrowAction])
        let upDownArrowAction = SKAction.repeatForever(upDownArrowSequence)
        arrow.run(upDownArrowAction, withKey: "upDownArrow")
        
        addChild(arrow)
        
        
        initFruits()
        
        
        
        // SETTING THE GRAVITY LIKE IN REAL WORLD
        self.physicsWorld.gravity = CGVector(dx: 0, dy: -1)
        
        // IN ORDER TO DON'T LET GO AWAY THE PHISICS OBJECT INSIDE THE SCENE. THEY WILL JUST BOUNCE AWAY
        let sceneBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        sceneBody.friction = 0
        self.physicsBody = sceneBody
        
        
        

    }
    
    func createRandomFruit() -> Fruit {
        let random = Int(arc4random_uniform(UInt32(fruitCount)))
        let fruitRandom = FruitName(rawValue: random)
        let newFruit = Fruit(theFruit: fruitRandom!)
        newFruit.physicsBody = SKPhysicsBody(rectangleOf: size)
        newFruit.isUserInteractionEnabled = true
        newFruit.physicsBody = SKPhysicsBody(texture: newFruit.texture!, size: newFruit.size)
        // THE NODE WILL BE AFFECTED BY THE GRAVITY SETTED IN THE SCENE
        newFruit.physicsBody?.affectedByGravity = true
        // TO CONTROL THE BOUNCING. IF SETTED TO 1, THE NODE WILL RETURN AT THE STARTING POSITION
        newFruit.physicsBody?.restitution = 0.3
        // SETTING THE AIR RESISTANCE
        newFruit.physicsBody?.linearDamping = 0
        newFruit.physicsBody?.isDynamic = false
        newFruit.zPosition = 20
        fruitList.append(newFruit)
        return newFruit
        
    }
    
    func initFruits () {
        // crea una lista di frutti random da mettere nella pagina
        for _ in 0...2 {
            let newFruit = createRandomFruit()
            addChild(newFruit)
        }
        columnizeSpriteList(columns: 3, items: fruitList)
        
        for fruit in fruitList {
            fruit.originalPosition = fruit.position
        }
    }
    
    
    override func update(_ currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        
        print("scores")
        print(scores)
        print("scoreToCompleteThisLevel")
        print(scoreToCompleteThisLevel)
        print("didOnce")
        print(didOnce)
        print("complexity")
        print(complexity)
        
        if scores == scoreToCompleteThisLevel {
            
                if !didOnce {
                    didOnce = true
                    
                    // se è stato raggiunto il punteggio sale il livello

                    nextLevel()
                    
                    
                }
        }
        else {
            for fruit in fruitList {
                if(!fruit.isIntoTheGlass && boxArrow.contains(fruit.position)) {
                    
                    // UPDATES SCORES
                    scores = scores + 1
                    
                    fruit.isIntoTheGlass = true
                    fruit.physicsBody?.isDynamic = true
                    fruit.isUserInteractionEnabled = false
                    fruit.removeAction(forKey: "wiggle")
                    fruit.zPosition = 3

                    
                    
                    sayThis(string: String(scores))
                    
            
                    
                    
                    // ADDS THE COUNT TO THE SCENE
                    countNumber.removeFromParent()
                    switch scores {
                    case 1: countNumber = Number(theNumber: NumberName.One)
                    case 2: countNumber = Number(theNumber: NumberName.Two)
                    case 3: countNumber = Number(theNumber: NumberName.Three)
                    case 4: countNumber = Number(theNumber: NumberName.Four)
                    case 5: countNumber = Number(theNumber: NumberName.Five)
                    case 6: countNumber = Number(theNumber: NumberName.Six)
                    case 7: countNumber = Number(theNumber: NumberName.Seven)
                    case 8: countNumber = Number(theNumber: NumberName.Eight)
                    case 9: countNumber = Number(theNumber: NumberName.Nine)
                    default: countNumber = Number(theNumber: NumberName.One)
                    }
                    
                    countNumber.position = CGPoint(x: 200, y: 200)
                    countNumber.zPosition = 1
                    addChild(countNumber)
                    
                    let liftUp = SKAction.scale(to: 0.8, duration: 0.2)
                    let liftDown = SKAction.scale(to: 1, duration: 0.2)
                    SKAction.sequence([liftUp, liftDown, liftUp])
                    countNumber.run(liftUp, withKey: "bumble")
                    // ____________
                    
                    if (fruitList.count < scoreToCompleteThisLevel) {
                        let newFruit = createRandomFruit()
                        newFruit.position = fruit.originalPosition
                        newFruit.originalPosition = fruit.originalPosition
                        addChild(newFruit)
                    }
            
                }
            }
        }
        
     
    }
    // END UPDATE
    
    
    
    
}
