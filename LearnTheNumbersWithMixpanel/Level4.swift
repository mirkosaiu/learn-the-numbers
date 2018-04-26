//
//  Level4.swift
//  Learn the Numbers
//
//  Created by Mirko Saiu on 05/07/15.
//  Copyright (c) 2015 Mirko Saiu. All rights reserved.
//


import Foundation
import SpriteKit


class Level4: SKSceneSuper {
    
    var scoreToCompleteThisLevel = 0
    var scores: Int = 0
    var hasBeenPerformedOnce = false
    
    let level = userDefaults.integerForKey(defaultsKeys.level)
    let complexity: Int = userDefaults.integerForKey(defaultsKeys.complexity)

    var marginBottom = CGFloat(0)
    var marginLeft = CGFloat(0)
    var marginOut = CGFloat(0)
    
    var distance = CGFloat(80)
    
    var ct_list_1 = [CheckTrack]()
    var ct_list_2 = [CheckTrack]()
    var ct_list_3 = [CheckTrack]()
    var ct_list_4 = [CheckTrack]()
    var ct_list_5 = [CheckTrack]()
    var ct_list_6 = [CheckTrack]()
    var ct_list_7 = [CheckTrack]()
    var ct_list_8 = [CheckTrack]()
    var ct_list_9 = [CheckTrack]()
    
    var next_ct = 0
    var last_ct = -1
    
    
    var shadowOne = SKSpriteNode(imageNamed: "shadow_one")
    var shadowTwo = SKSpriteNode(imageNamed: "shadow_two")
    var shadowThree = SKSpriteNode(imageNamed: "shadow_three")
    var shadowFour = SKSpriteNode(imageNamed: "shadow_four")
    var shadowFive = SKSpriteNode(imageNamed: "shadow_five")
    var shadowSix = SKSpriteNode(imageNamed: "shadow_six")
    var shadowSeven = SKSpriteNode(imageNamed: "shadow_seven")
    var shadowEight = SKSpriteNode(imageNamed: "shadow_eight")
    var shadowNine = SKSpriteNode(imageNamed: "shadow_nine")
    
    
    var actualShadow = 1
    var actualShadowObject = SKSpriteNode()
    var actualShadowChecktracks = [CheckTrack]()
    
    override func didMoveToView(view: SKView) {
        super.didMoveToView(view)
        
        mixpanel.track("Level start",  properties: ["Level": String(level), "Complexity": String(complexity)])
        
        setBackgroundSong()
        
        scoreToCompleteThisLevel = complexity*3
        
        marginBottom = height/2.0+100
        marginOut = width/2+300
        marginLeft = width/2.0 + marginOut
        
        setBaseEnvironment()
        setReturnButton()

        
        // ONE
        
        // inizializza 7 pallini
        for index in 0...6 {
            let ct = CheckTrack()
            ct_list_1.append(ct)
            ct.id = index
            ct.next = index+1
            ct.zPosition = 4
        }
        
        
        
        
        ct_list_1[0].startLoop()
        
        shadowOne.position = CGPoint(x: marginLeft-50, y: marginBottom-150)
        shadowOne.zPosition = 2
        addChild(shadowOne)
        
        //one
        ct_list_1[2].position = CGPoint(x: marginLeft, y: marginBottom)
        ct_list_1[3].position = CGPoint(x: marginLeft, y: marginBottom-distance*1)
        ct_list_1[4].position = CGPoint(x: marginLeft, y: marginBottom-distance*2)
        ct_list_1[5].position = CGPoint(x: marginLeft, y: marginBottom-distance*3)
        ct_list_1[6].position = CGPoint(x: marginLeft, y: marginBottom-distance*4)
        ct_list_1[1].position = CGPoint(x: marginLeft-distance/1.5, y: marginBottom-distance/1.7)
        ct_list_1[0].position = CGPoint(x: marginLeft-distance/1.5-distance/1.5, y: marginBottom-distance/1.7-distance/1.7)
        
        // gli inserisce tutti nella scene
        ct_list_1.forEach({x in self.addChild(x)})
        
        
        
        actualShadowObject = shadowOne
        actualShadowChecktracks = ct_list_1
        
        // END ONE
        

        showActualShadowWithChecktraks()
        
        
        
        // TWO
        
        // inizializza 10 pallini
        for index in 0...9 {
            let ct = CheckTrack()
            ct_list_2.append(ct)
            ct.id = index
            ct.next = index+1
            ct.zPosition = 4
        }
        
        ct_list_2[0].startLoop()
        
        shadowTwo.position = CGPoint(x: marginLeft, y: marginBottom-150)
        shadowTwo.zPosition = 2
        addChild(shadowTwo)
        
        
        ct_list_2[0].position = CGPoint(x: marginLeft-distance/1.5-distance/1.5, y: marginBottom-distance/2.3)
        ct_list_2[1].position = CGPoint(x: marginLeft-distance/2.1, y: marginBottom)
        ct_list_2[2].position = CGPoint(x: marginLeft+distance/2.1, y: marginBottom-distance/4)
        ct_list_2[3].position = CGPoint(x: marginLeft+distance/1.2, y: marginBottom-distance)
        ct_list_2[4].position = CGPoint(x: marginLeft+distance*0.5, y: marginBottom-distance*1.8)
        ct_list_2[5].position = CGPoint(x: marginLeft-10, y: marginBottom-200)
        ct_list_2[6].position = CGPoint(x: marginLeft-60, y: marginBottom-255)
        ct_list_2[7].position = CGPoint(x: marginLeft-100, y: marginBottom-305)
        ct_list_2[8].position = CGPoint(x: marginLeft-15, y: marginBottom-305)
        ct_list_2[9].position = CGPoint(x: marginLeft+60, y: marginBottom-305)
        // gli inserisce tutti nella scene
        ct_list_2.forEach({x in self.addChild(x)})
        
        // END TWO
        
        
        
        
        
        
        
        
        
        // THREE
        
        // inizializza 10 pallini
        for index in 0...9 {
            let ct = CheckTrack()
            ct_list_3.append(ct)
            ct.id = index
            ct.next = index+1
            ct.zPosition = 4
        }
        
        ct_list_3[0].startLoop()
        
        shadowThree.position = CGPoint(x: marginLeft, y: marginBottom-150)
        shadowThree.zPosition = 2
        addChild(shadowThree)
        
        
        ct_list_3[0].position = CGPoint(x: marginLeft-100, y: marginBottom-20)
        ct_list_3[1].position = CGPoint(x: marginLeft-20, y: marginBottom)
        ct_list_3[2].position = CGPoint(x: marginLeft+55, y: marginBottom-20)
        ct_list_3[3].position = CGPoint(x: marginLeft+70, y: marginBottom-90)
        ct_list_3[4].position = CGPoint(x: marginLeft, y: marginBottom-135)
        ct_list_3[5].position = CGPoint(x: marginLeft+70, y: marginBottom-170)
        ct_list_3[6].position = CGPoint(x: marginLeft+100, y: marginBottom-230)
        ct_list_3[7].position = CGPoint(x: marginLeft+60, y: marginBottom-290)
        ct_list_3[8].position = CGPoint(x: marginLeft-10, y: marginBottom-305)
        ct_list_3[9].position = CGPoint(x: marginLeft-75, y: marginBottom-305)

        
        // gli inserisce tutti nella scene
        ct_list_3.forEach({x in self.addChild(x)})
        
        // END THREE
        
        
        
        
        
        
        
        
        // FOUR
        
        // inizializza 10 pallini
        for index in 0...10 {
        let ct = CheckTrack()
        ct_list_4.append(ct)
        ct.id = index
        ct.next = index+1
        ct.zPosition = 4
        }
        
        ct_list_4[0].startLoop()
        
        shadowFour.position = CGPoint(x: marginLeft, y: marginBottom-150)
        shadowFour.zPosition = 2
        addChild(shadowFour)
        
        
        ct_list_4[0].position = CGPoint(x: marginLeft+130, y: marginBottom-235)
        ct_list_4[1].position = CGPoint(x: marginLeft+60, y: marginBottom-235)
        ct_list_4[2].position = CGPoint(x: marginLeft-30, y: marginBottom-235)
        ct_list_4[3].position = CGPoint(x: marginLeft-110, y: marginBottom-235)
        ct_list_4[4].position = CGPoint(x: marginLeft-90, y: marginBottom-165)
        ct_list_4[5].position = CGPoint(x: marginLeft-50, y: marginBottom-105)
        ct_list_4[6].position = CGPoint(x: marginLeft-10, y: marginBottom-45)
        ct_list_4[7].position = CGPoint(x: marginLeft+50, y: marginBottom)
        ct_list_4[8].position = CGPoint(x: marginLeft+55, y: marginBottom-80)
        ct_list_4[9].position = CGPoint(x: marginLeft+60, y: marginBottom-160)
        ct_list_4[10].position = CGPoint(x: marginLeft+60, y: marginBottom-310)
        
        
        // gli inserisce tutti nella scene
        ct_list_4.forEach({x in self.addChild(x)})
        
        // END FOUR
        
        
        
        
        
        
        
        // FIVE
        
        // inizializza 10 pallini
        for index in 0...12 {
            let ct = CheckTrack()
            ct_list_5.append(ct)
            ct.id = index
            ct.next = index+1
            ct.zPosition = 4
        }
        
        ct_list_5[0].startLoop()
        
        shadowFive.position = CGPoint(x: marginLeft, y: marginBottom-150)
        shadowFive.zPosition = 2
        addChild(shadowFive)
        
        
        ct_list_5[0].position = CGPoint(x: marginLeft+90, y: marginBottom)
        ct_list_5[1].position = CGPoint(x: marginLeft+33, y: marginBottom)
        ct_list_5[2].position = CGPoint(x: marginLeft-36, y: marginBottom)
        ct_list_5[3].position = CGPoint(x: marginLeft-100, y: marginBottom)
        ct_list_5[4].position = CGPoint(x: marginLeft-100, y: marginBottom-80)
        ct_list_5[5].position = CGPoint(x: marginLeft-90, y: marginBottom-150)
        ct_list_5[6].position = CGPoint(x: marginLeft-20, y: marginBottom-135)
        ct_list_5[7].position = CGPoint(x: marginLeft+50, y: marginBottom-135)
        ct_list_5[8].position = CGPoint(x: marginLeft+100, y: marginBottom-180)
        ct_list_5[9].position = CGPoint(x: marginLeft+90, y: marginBottom-250)
        ct_list_5[10].position = CGPoint(x: marginLeft+40, y: marginBottom-300)
        ct_list_5[11].position = CGPoint(x: marginLeft-30, y: marginBottom-300)
        ct_list_5[12].position = CGPoint(x: marginLeft-100, y: marginBottom-280)
        
        
        
        
        // gli inserisce tutti nella scene
        ct_list_5.forEach({x in self.addChild(x)})
        
        // END FIVE
        
        
        
        for index in 0...9 {
            let ct = CheckTrack()
            ct_list_6.append(ct)
            ct.id = index
            ct.next = index+1
            ct.zPosition = 4
        }
        
        ct_list_6[0].startLoop()
        
        shadowSix.position = CGPoint(x: marginLeft, y: marginBottom-150)
        shadowSix.zPosition = 2
        addChild(shadowSix)
        
        
        ct_list_6[0].position = CGPoint(x: marginLeft+20, y: marginBottom+10)
        ct_list_6[1].position = CGPoint(x: marginLeft-20, y: marginBottom-40)
        ct_list_6[2].position = CGPoint(x: marginLeft-60, y: marginBottom-100)
        ct_list_6[3].position = CGPoint(x: marginLeft-80, y: marginBottom-170)
        ct_list_6[4].position = CGPoint(x: marginLeft-75, y: marginBottom-240)
        ct_list_6[5].position = CGPoint(x: marginLeft-30, y: marginBottom-300)
        ct_list_6[6].position = CGPoint(x: marginLeft+40, y: marginBottom-300)
        ct_list_6[7].position = CGPoint(x: marginLeft+80, y: marginBottom-240)
        ct_list_6[8].position = CGPoint(x: marginLeft+70, y: marginBottom-170)
        ct_list_6[9].position = CGPoint(x: marginLeft, y: marginBottom-150)
        
        
        // gli inserisce tutti nella scene
        ct_list_6.forEach({x in self.addChild(x)})
        
        // END SIX

        
        
        
        
        // SEVEN
        
        for index in 0...8 {
            let ct = CheckTrack()
            ct_list_7.append(ct)
            ct.id = index
            ct.next = index+1
            ct.zPosition = 4
        }
        
        ct_list_7[0].startLoop()
        
        shadowSeven.position = CGPoint(x: marginLeft, y: marginBottom-150)
        shadowSeven.zPosition = 2
        addChild(shadowSeven)
        
        
        ct_list_7[0].position = CGPoint(x: marginLeft-100, y: marginBottom+5)
        ct_list_7[1].position = CGPoint(x: marginLeft-30, y: marginBottom+5)
        ct_list_7[2].position = CGPoint(x: marginLeft+40, y: marginBottom+5)
        ct_list_7[3].position = CGPoint(x: marginLeft+110, y: marginBottom+5)
        ct_list_7[4].position = CGPoint(x: marginLeft+80, y: marginBottom-60)
        ct_list_7[5].position = CGPoint(x: marginLeft+50, y: marginBottom-120)
        ct_list_7[6].position = CGPoint(x: marginLeft+20, y: marginBottom-180)
        ct_list_7[7].position = CGPoint(x: marginLeft-10, y: marginBottom-240)
        ct_list_7[8].position = CGPoint(x: marginLeft-40, y: marginBottom-300)
        
        
        
        // gli inserisce tutti nella scene
        ct_list_7.forEach({x in self.addChild(x)})
        
        // END SEVEN
       
    
  
        
        // EIGHT
        
        for index in 0...10 {
            let ct = CheckTrack()
            ct_list_8.append(ct)
            ct.id = index
            ct.next = index+1
            ct.zPosition = 4
        }
        
        ct_list_8[0].startLoop()
        
        shadowEight.position = CGPoint(x: marginLeft, y: marginBottom-150)
        shadowEight.zPosition = 2
        addChild(shadowEight)
        
        
        ct_list_8[0].position = CGPoint(x: marginLeft+50, y: marginBottom-100)
        ct_list_8[1].position = CGPoint(x: marginLeft+75, y: marginBottom-35)
        ct_list_8[2].position = CGPoint(x: marginLeft+30, y: marginBottom+15)
        ct_list_8[3].position = CGPoint(x: marginLeft-45, y: marginBottom-10)
        ct_list_8[4].position = CGPoint(x: marginLeft-45, y: marginBottom-85)
        ct_list_8[5].position = CGPoint(x: marginLeft, y: marginBottom-150)
        ct_list_8[6].position = CGPoint(x: marginLeft+70, y: marginBottom-200)
        ct_list_8[7].position = CGPoint(x: marginLeft+80, y: marginBottom-270)
        ct_list_8[8].position = CGPoint(x: marginLeft+20, y: marginBottom-315)
        ct_list_8[9].position = CGPoint(x: marginLeft-60, y: marginBottom-290)
        ct_list_8[10].position = CGPoint(x: marginLeft-70, y: marginBottom-210)
        
        
        // gli inserisce tutti nella scene
        ct_list_8.forEach({x in self.addChild(x)})
        
        // END EIGHT
        
        
       
        // NINE
        
        for index in 0...8 {
            let ct = CheckTrack()
            ct_list_9.append(ct)
            ct.id = index
            ct.next = index+1
            ct.zPosition = 4
        }
        
        ct_list_9[0].startLoop()
        
        shadowNine.position = CGPoint(x: marginLeft, y: marginBottom-150)
        shadowNine.zPosition = 2
        addChild(shadowNine)
        
        
        ct_list_9[0].position = CGPoint(x: marginLeft-40, y: marginBottom-310)
        ct_list_9[1].position = CGPoint(x: marginLeft+10, y: marginBottom-255)
        ct_list_9[2].position = CGPoint(x: marginLeft+60, y: marginBottom-190)
        ct_list_9[3].position = CGPoint(x: marginLeft+80, y: marginBottom-110)
        ct_list_9[4].position = CGPoint(x: marginLeft+60, y: marginBottom-30)
        ct_list_9[5].position = CGPoint(x: marginLeft-20, y: marginBottom)
        ct_list_9[6].position = CGPoint(x: marginLeft-80, y: marginBottom-50)
        ct_list_9[7].position = CGPoint(x: marginLeft-70, y: marginBottom-130)
        ct_list_9[8].position = CGPoint(x: marginLeft, y: marginBottom-150)
        
        
        // gli inserisce tutti nella scene
        ct_list_9.forEach({x in self.addChild(x)})
        
        // END NINE
    }
    
    
    
    // ACTION SHOW NUMBER
    func showActualShadowWithChecktraks() {
        let showNumber = SKAction.moveTo(CGPoint(x: actualShadowObject.position.x - marginOut, y: actualShadowObject.position.y), duration: 3)
        for ct in actualShadowChecktracks{
            let showCt = SKAction.moveTo(CGPoint(x: ct.position.x - marginOut, y: ct.position.y), duration: 3)
            
            ct.runAction(showCt)
        }
        actualShadowObject.runAction(showNumber)
        
    }
    
    
    
    
    
    // ACTION HIDE NUMBER
    func hideActualShadowWithChecktraks() {
        let showNumber = SKAction.moveTo(CGPoint(x: actualShadowObject.position.x - marginOut, y: actualShadowObject.position.y), duration: 3)
        for ct in actualShadowChecktracks{
            let showCt = SKAction.moveTo(CGPoint(x: ct.position.x - marginOut, y: ct.position.y), duration: 3)
            
            ct.runAction(showCt)
        }
        actualShadowObject.runAction(showNumber)
        
    }
    
    
    
    
    // GIVES THE ACTUAL SHADOW SPRITE
    func getActualShadowObject () -> SKSpriteNode {
        switch(actualShadow) {
        case 1: return shadowOne
        case 2: return shadowTwo
        case 3: return shadowThree
        case 4: return shadowFour
        case 5: return shadowFive
        case 6: return shadowSix
        case 7: return shadowSeven
        case 8: return shadowEight
        case 9: return shadowNine
        default: return shadowOne
        }
    }
    
    
    
    // GIVES THE ACTUAL SHADOW SPRITE
    func getActualShadowChecktraks () -> [CheckTrack] {
        switch(actualShadow) {
        case 1: return ct_list_1
        case 2: return ct_list_2
        case 3: return ct_list_3
        case 4: return ct_list_4
        case 5: return ct_list_5
        case 6: return ct_list_6
        case 7: return ct_list_7
        case 8: return ct_list_8
        case 9: return ct_list_9
        default: return ct_list_1
        }
    }
    
    
    // AL TOCCO SULLO SCHERMO
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event)
        
        for touch in touches {
            let touch: UITouch = touch
            let pos = touch.locationInNode(self)
            trackHandler(pos)
        }
        
    }
    
    
    
    
    
    
    
    // ALLA FINE DEL TOCCO
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for _ in touches {
            
            // CONTROLLA SE QUALCUNO NON é STATO PASSATO
            var someoneNotChecked = false
            for ct in actualShadowChecktracks {
                if !ct.checked {
                    someoneNotChecked = true
                }
            }
            
            if someoneNotChecked {
                reset()
            } else {
                // COMPLETATO!
                // VAI AL PROSSIMO
                next_ct = 0
                last_ct = -1
                
                scores = scores + 1
                
                sayThis(String(scores))
                if(scores < scoreToCompleteThisLevel) {
                    hideActualShadowWithChecktraks()
                    actualShadow = actualShadow + 1
                    actualShadowObject = getActualShadowObject()
                    actualShadowChecktracks = getActualShadowChecktraks()
                    showActualShadowWithChecktraks()
                }
                else {
                    if(!hasBeenPerformedOnce) {
                        hasBeenPerformedOnce = true
                        nextLevel()
                    }
                }
            }
        }
    }
    
    func reset() {
        for ct in actualShadowChecktracks{
            ct.off()
        }
        actualShadowChecktracks[0].texture = SKTexture(imageNamed: "check_track_blue")
        next_ct = 0
        last_ct = -1
    }
    
    func trackHandler (touchPosition: CGPoint) {
        //controlla se un checktrack è stato già toccato
        var someoneChecked = false
        for ct in actualShadowChecktracks {
            if ct.checked {
                someoneChecked = true
            }
        }
        
        for ct in actualShadowChecktracks {
            if actualShadowObject.containsPoint(touchPosition) {
                if ct.containsPoint(touchPosition) {
                    // punto iniziale
                    if !someoneChecked && ct.id == next_ct {
                        ct.on()
                        next_ct = ct.next
                        last_ct = ct.id
                        actualShadowChecktracks[next_ct].texture = SKTexture(imageNamed: "check_track_blue")
                    }
                    else if someoneChecked && ct.id == next_ct {
                        ct.on()
                        next_ct = ct.next
                        last_ct = ct.id
                        // MARKED WITH A DIFFERENT COLOR THE NEXT CHECKTRACK
                        if(next_ct < actualShadowChecktracks.count) {
                            actualShadowChecktracks[next_ct].texture = SKTexture(imageNamed: "check_track_blue")
                        }
                    }
                    // JUST FOR THE NUMBER 4
                    else if actualShadow == 4 && someoneChecked && ct.id == 1 {

                    }
                    else if someoneChecked && ct.id != last_ct && ct.id != next_ct {
                        reset()
                    }
                }
            }
            else {
                reset()
            }
        }
    }
}