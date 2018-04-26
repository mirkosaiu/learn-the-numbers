//
//  Fruit.swift
//  Learn the Numbers
//
//  Created by Mirko Saiu on 05/07/15.
//  Copyright (c) 2015 Mirko Saiu. All rights reserved.
//

import SpriteKit
import Foundation

enum FruitName: Int {
    case Blackberry = 0,
    Strawberry,
    Cherry,
    Orange,
    Banana
}

enum FruitBigName: Int {
    case BlackberryBig = 0,
    StrawberryBig,
    CherryBig,
    OrangeBig,
    BananaBig
}

let fruitCount: Int = 5

class Fruit: SKSpriteNode {
    let textureFruit : SKTexture
    var outGame = false
    var isIntoTheGlass = false
    var originalPosition = CGPoint()
    
    
    
    init(theFruit: FruitName) {
        switch theFruit {
        case .Blackberry:
            textureFruit = SKTexture(imageNamed: "blackberry")
        case .Strawberry:
            textureFruit = SKTexture(imageNamed: "strawberry")
        case .Cherry:
            textureFruit = SKTexture(imageNamed: "cherry")
        case .Orange:
            textureFruit = SKTexture(imageNamed: "orange")
        case .Banana:
            textureFruit = SKTexture(imageNamed: "banana")
        }
        
        super.init(texture: textureFruit, color: UIColor(), size: textureFruit.size())
        
        bindWiggleAction()
        
        // set properties defined in super
        userInteractionEnabled = true

    }
    
    init(theFruit: FruitBigName) {
        switch theFruit {
        case .BlackberryBig:
            textureFruit = SKTexture(imageNamed: "blackberry_big")
        case .StrawberryBig:
            textureFruit = SKTexture(imageNamed: "strawberry_big")
        case .CherryBig:
            textureFruit = SKTexture(imageNamed: "cherry_big")
        case .OrangeBig:
            textureFruit = SKTexture(imageNamed: "orange_big")
        case .BananaBig:
            textureFruit = SKTexture(imageNamed: "banana_big")
        }
        
        super.init(texture: textureFruit, color: UIColor(), size: textureFruit.size())
        
        
        
        
        bindWiggleAction()
        
        // set properties defined in super
        userInteractionEnabled = false
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if(!isIntoTheGlass){
            for touch in touches {
                let touch: UITouch = touch
                let location = touch.locationInNode(scene!)
                position = location
            }
        }
    }
    
    
    func bindWiggleAction() {
        let rotateRight = SKAction.rotateByAngle(0.15, duration: 0.5)
        let rotateLeft = SKAction.rotateByAngle(-0.15, duration: 0.5)
        let rotation = SKAction.sequence([rotateLeft,rotateRight,rotateRight,rotateLeft])
        let wiggle = SKAction.repeatActionForever(rotation)
        
        // aggiunge il wiggle a tutti i frutti
        runAction(wiggle, withKey: "wiggle")
        
        
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for _ in touches {
            zPosition = 20
            zRotation = 0
            
            removeActionForKey("wiggle")
            
            let liftUp = SKAction.scaleTo(1.2, duration: 0.2)
            runAction(liftUp, withKey: "pickup")
        }
    }
    
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for _ in touches {
            
            
            let liftDown = SKAction.scaleTo(1.0, duration: 0.2)
            runAction(liftDown, withKey: "drop")
            if(!isIntoTheGlass) {
                bindWiggleAction()
            }
        }
    }
}