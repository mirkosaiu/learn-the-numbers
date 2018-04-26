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
    let level = userDefaults.integerForKey(defaultsKeys.level)
    let complexity: Int = userDefaults.integerForKey(defaultsKeys.complexity)
    var scoreToCompleteThisLevel = 0
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
    
    
    override func didMoveToView(view: SKView) {
        super.didMoveToView(view)
        
        
        scoreToCompleteThisLevel = 3 * complexity
        
        mixpanel.track("Level start",  properties: ["Level": String(level), "Complexity": String(complexity)])
        
        
        setBaseEnvironment()
        setBackgroundSong()
        setReturnButton()
        
        // GLASS
        glass.position = CGPoint(x: size.width/2 - glass.size.width/2, y: 20)
        glass.zPosition = 19
        
        glass.anchorPoint = CGPoint(x: 0, y: 0)
        addChild(glass)
        
        
        
        let path: CGMutablePathRef = CGPathCreateMutable()
        let offsetX: CGFloat = 0
        let offsetY: CGFloat = 0
        
        CGPathMoveToPoint(path, nil, 4 - offsetX, 209 - offsetY);
        CGPathAddLineToPoint(path, nil, 49 - offsetX, 16 - offsetY);
        CGPathAddLineToPoint(path, nil, 247 - offsetX, 17 - offsetY);
        CGPathAddLineToPoint(path, nil, 307 - offsetX, 209 - offsetY);
        CGPathAddLineToPoint(path, nil, 302 - offsetX, 209 - offsetY);
        CGPathAddLineToPoint(path, nil, 245 - offsetX, 20 - offsetY);
        CGPathAddLineToPoint(path, nil, 52 - offsetX, 19 - offsetY);
        CGPathAddLineToPoint(path, nil, 7 - offsetX, 208 - offsetY);
        CGPathCloseSubpath(path)
        
        
        glass.physicsBody = SKPhysicsBody(polygonFromPath: path)
        glass.physicsBody?.dynamic = false
        glass.physicsBody?.affectedByGravity = false
        
        
        
        
        
        
        
        
        
        
        // BOX ARROW
        boxArrow.position = CGPoint(x: size.width/2, y: height/2)
        boxArrow.zPosition = 19
        addChild(boxArrow)
        
        
        // ARROW
        arrow.position = CGPoint(x: size.width/2, y: height/2+10)
        arrow.zPosition = 19
        
        
        // UP AND DOWN ARROW ACTION
        let downArrowAction = SKAction.moveTo(CGPoint(x: arrow.position.x, y: arrow.position.y-20.0), duration: 1)
        let upArrowAction = SKAction.moveTo(CGPoint(x: arrow.position.x, y: arrow.position.y), duration: 1)
        let upDownArrowSequence = SKAction.sequence([downArrowAction, upArrowAction])
        let upDownArrowAction = SKAction.repeatActionForever(upDownArrowSequence)
        arrow.runAction(upDownArrowAction, withKey: "upDownArrow")
        
        addChild(arrow)
        
        
        initFruits()
        
        
        
        // SETTING THE GRAVITY LIKE IN REAL WORLD
        self.physicsWorld.gravity = CGVectorMake(0, -1)
        
        // IN ORDER TO DON'T LET GO AWAY THE PHISICS OBJECT INSIDE THE SCENE. THEY WILL JUST BOUNCE AWAY
        let sceneBody = SKPhysicsBody(edgeLoopFromRect: self.frame)
        sceneBody.friction = 0
        self.physicsBody = sceneBody
        
        
        

    }
    
    func createRandomFruit() -> Fruit {
        let random = Int(arc4random_uniform(UInt32(fruitCount)))
        let fruitRandom = FruitName(rawValue: random)
        let newFruit = Fruit(theFruit: fruitRandom!)
        newFruit.physicsBody = SKPhysicsBody(rectangleOfSize: size)
        newFruit.userInteractionEnabled = true
        newFruit.physicsBody = SKPhysicsBody(texture: newFruit.texture!, size: newFruit.size)
        // THE NODE WILL BE AFFECTED BY THE GRAVITY SETTED IN THE SCENE
        newFruit.physicsBody?.affectedByGravity = true
        // TO CONTROL THE BOUNCING. IF SETTED TO 1, THE NODE WILL RETURN AT THE STARTING POSITION
        newFruit.physicsBody?.restitution = 0.3
        // SETTING THE AIR RESISTANCE
        newFruit.physicsBody?.linearDamping = 0
        newFruit.physicsBody?.dynamic = false
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
        columnizeSpriteList(3, items: fruitList)
        
        for fruit in fruitList {
            fruit.originalPosition = fruit.position
        }
    }
    
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        
        if scores != scoreToCompleteThisLevel {
            for fruit in fruitList {
                if(!fruit.isIntoTheGlass && boxArrow.containsPoint(fruit.position)) {
                    
                    // UPDATES SCORES
                    scores = scores + 1
                    
                    fruit.isIntoTheGlass = true
                    fruit.physicsBody?.dynamic = true
                    fruit.userInteractionEnabled = false
                    fruit.removeActionForKey("wiggle")
                    fruit.zPosition = 3

                    
                    
                    sayThis(String(scores))
                    
                    
                    
                    
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
                    
                    let liftUp = SKAction.scaleTo(0.8, duration: 0.2)
                    let liftDown = SKAction.scaleTo(1, duration: 0.2)
                    SKAction.sequence([liftUp, liftDown, liftUp])
                    countNumber.runAction(liftUp, withKey: "bumble")
                    // ____________
                    
                    if (fruitList.count < scoreToCompleteThisLevel) {
                        let newFruit = createRandomFruit()
                        newFruit.position = fruit.originalPosition
                        newFruit.originalPosition = fruit.originalPosition
                        addChild(newFruit)
                    }
                    
                    
                    
                }
            }
        } else {
            if !didOnce {
                didOnce = true
                
                // se è stato raggiunto il punteggio sale il livello

                nextLevel()
                
                
            }

        }
        
     
    }
    // END UPDATE
    
    
    
    
}