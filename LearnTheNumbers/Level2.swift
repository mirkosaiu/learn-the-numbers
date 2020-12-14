//
//  Level2.swift
//  Learn the Numbers
//
//  Created by Mirko Saiu on 05/07/15.
//  Copyright (c) 2015 Mirko Saiu. All rights reserved.
//

import Foundation
import SpriteKit

class Level2: SKScene {
    
    
    
    var lastTouch = CGPoint(x: 0, y: 0)
    
    var wayPoints: [CGPoint] = []
    
    
    override func didMove(to view: SKView) {

        
        //backgroundColor = SKColor.whiteColor()
        let bgSprite = SKSpriteNode(imageNamed: "bg_sky_vect")
        bgSprite.position = CGPoint(x: size.width*0.5, y: size.height*0.5)
        addChild(bgSprite)
        
        let clouds = SKSpriteNode(imageNamed: "clouds")
        clouds.position = CGPoint(x: 190, y: size.height-80)
        addChild(clouds)
        
        let grass = SKSpriteNode(imageNamed: "grass")
        grass.position = CGPoint(x: size.width*0.5, y: 25)
        addChild(grass)
        
        let bear = SKSpriteNode(imageNamed: "bear")
        bear.position = CGPoint(x: size.width-110, y: 140)
        addChild(bear)
        
        
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: UITouch = touches.first!
        
        let location = touch.location(in: self)
        lastTouch = location
        wayPoints.append(location)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: UITouch = touches.first!
        
        let location = touch.location(in: self)
        wayPoints.append(location)
        
        let path = CGMutablePath()
        path.move(to: CGPoint(x: location.x, y: location.y))
        path.addLine(to: CGPoint(x: lastTouch.x, y: lastTouch.y))
        
        let shapeNode = SKShapeNode()
        shapeNode.path = path
        shapeNode.name = "line"
        shapeNode.strokeColor = UIColor.gray
        shapeNode.lineWidth = 8
        shapeNode.zPosition = 1
        self.addChild(shapeNode)
        
        lastTouch = location
    }
    
    override func update(_ currentTime: TimeInterval) {
        
    }
    /*
    override func update(currentTime: NSTimeInterval) {
    dt = currentTime - lastUpdateTime
    lastUpdateTime = currentTime
    
    var path = CGPathCreateMutable()
    
    //CGPathMoveToPoint(path, nil, size.width/2, size.height/2)
    //CGPathAddLineToPoint(path, nil, size.width/2+30, size.height/2+60)
    if(wayPoints.count > 1){
    
    var i=0
    for point in wayPoints {
    if i == 0 {
    CGPathMoveToPoint(path, nil, point.x, point.y)
    } else {
    CGPathAddLineToPoint(path, nil, point.x, point.y)
    }
    i++
    }
    
    
    }
    
    }
    */
    
}
