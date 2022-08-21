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
        isUserInteractionEnabled = true

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
        isUserInteractionEnabled = false
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if(!isIntoTheGlass){
            for touch in touches {
                let touch: UITouch = touch
                let location = touch.location(in: scene!)
                position = location
            }
        }
    }
    
    
    func bindWiggleAction() {
        let rotateRight = SKAction.rotate(byAngle: 0.15, duration: 0.5)
        let rotateLeft = SKAction.rotate(byAngle: -0.15, duration: 0.5)
        let rotation = SKAction.sequence([rotateLeft,rotateRight,rotateRight,rotateLeft])
        let wiggle = SKAction.repeatForever(rotation)
        
        // aggiunge il wiggle a tutti i frutti
        run(wiggle, withKey: "wiggle")
        
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for _ in touches {
            zPosition = 20
            zRotation = 0
            
            removeAction(forKey: "wiggle")
            
            let liftUp = SKAction.scale(to: 1.2, duration: 0.2)
            run(liftUp, withKey: "pickup")
        }
    }
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for _ in touches {
            
            
            let liftDown = SKAction.scale(to: 1.0, duration: 0.2)
            run(liftDown, withKey: "drop")
            if(!isIntoTheGlass) {
                bindWiggleAction()
            }
        }
    }
}
