//
//  Number.swift
//  Learn the Numbers
//
//  Created by Mirko Saiu on 05/07/15.
//  Copyright (c) 2015 Mirko Saiu. All rights reserved.
//

import Foundation
import SpriteKit

enum NumberName: Int{
    case One = 1,
    Two,
    Three,
    Four,
    Five,
    Six,
    Seven,
    Eight,
    Nine,
    Null = -1
}

class Number: SKSpriteNode {
    
    let textureNumber : SKTexture
    var inTheHole = false
    var numberCode: NumberName = NumberName.One
    var isDynamic = true
    var numberInt: Int!
    
    
    init(theNumber: NumberName) {
        switch theNumber{
        case .One:
            textureNumber = SKTexture(imageNamed: "one")
            numberCode = NumberName.One
            numberInt = 1
        case .Two:
            textureNumber = SKTexture(imageNamed: "two")
            numberCode = NumberName.Two
            numberInt = 2
        case .Three:
            textureNumber = SKTexture(imageNamed: "three")
            numberCode = NumberName.Three
            numberInt = 3
        case .Four:
            textureNumber = SKTexture(imageNamed: "4")
            numberCode = NumberName.Four
            numberInt = 4
        case .Five:
            textureNumber = SKTexture(imageNamed: "5")
            numberCode = NumberName.Five
            numberInt = 5
        case .Six:
            textureNumber = SKTexture(imageNamed: "6")
            numberCode = NumberName.Six
            numberInt = 6
        case .Seven:
            textureNumber = SKTexture(imageNamed: "7")
            numberCode = NumberName.Seven
            numberInt = 7
        case .Eight:
            textureNumber = SKTexture(imageNamed: "8")
            numberCode = NumberName.Eight
            numberInt = 8
        case .Nine:
            textureNumber = SKTexture(imageNamed: "9")
            numberCode = NumberName.Nine
            numberInt = 9
        default:
            textureNumber = SKTexture(imageNamed: "one")
            numberCode = NumberName.One
            numberInt = 1
        }
        super.init(texture: textureNumber, color: UIColor(), size: textureNumber.size())
        
        // set properties defined in super
        /*physicsBody?.dynamic = true
        physicsBody?.affectedByGravity = true*/
 
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if !inTheHole {
            for touch in touches {
                let liftUp = SKAction.scaleTo(1.05, duration: 0.2)
                runAction(liftUp, withKey: "pickup")
                
                let touch: UITouch = touch 
                let location = touch.locationInNode(scene!)
                zRotation = 0.0
                position = location
            }
        }
    }
    
    
    
    
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        physicsBody?.dynamic = false
        isDynamic = false
        
        if !inTheHole {
            for touch in touches {
                let touch: UITouch = touch 
                let location = touch.locationInNode(scene!)
                zRotation = 0.0
                position = location
            }
        }
        
        
    }
    
    
    
    
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for _ in touches {
            let liftDown = SKAction.scaleTo(1.0, duration: 0.2)
            runAction(liftDown, withKey: "drop")
            physicsBody?.dynamic = true
        }
    }

}