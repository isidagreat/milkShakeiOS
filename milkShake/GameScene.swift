//
//  GameScene.swift
//  milkShake
//
//  Created by Isidro Arzate on 7/5/18.
//  Copyright © 2018 Isidro Arzate. All rights reserved.
//

import SpriteKit
import GameplayKit
import CoreGraphics
import CoreMotion


class GameScene: SKScene {
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    
    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "background.jpg")
        background.size = self.frame.size;
        background.zPosition = 0
        addChild(background)
        
        let cow = SKSpriteNode(imageNamed: "cow.png")
        cow.xScale = 0.5
        cow.yScale = 0.5
        cow.zPosition = 1
        cow.position.y += 200.00
        addChild(cow)
        
        let belt = SKSpriteNode(imageNamed: "belt.png")
        belt.zPosition = 2
        belt.position.y -= 500.0
        addChild(belt)
        
        let belt2 = SKSpriteNode(imageNamed: "belt.png")
        belt2.zPosition = 2
        belt2.position.y -= 500
        belt2.position.x += 1000
        addChild(belt2)
        let belt3 = SKSpriteNode(imageNamed: "belt.png")
        belt3.zPosition = 2
        belt3.position.y -= 500
        belt3.position.x -= 1000
        addChild(belt3)
        
        
        let emptyCup = SKSpriteNode(imageNamed: "emptyCup.png")
        emptyCup.zPosition = 3
        emptyCup.xScale = 0.15
        emptyCup.yScale = 0.15
        emptyCup.position.y -= 450.0
        addChild(emptyCup)
        
        let emptyCup2 = SKSpriteNode(imageNamed: "emptyCup.png")
        emptyCup2.zPosition = 3
        emptyCup2.xScale = 0.15
        emptyCup2.yScale = 0.15
        emptyCup2.position.y -= 450.0
        emptyCup2.position.x += 200
        addChild(emptyCup2)
        
        let filledCup = SKSpriteNode(imageNamed: "FilledCup.png")
        filledCup.zPosition = 3
        filledCup.xScale = 0.22
        filledCup.yScale = 0.22
        filledCup.position.y -= 450.0
        filledCup.position.x -= 200
        addChild(filledCup)
        
        
//        let fadeAway = SKAction.fadeOut(withDuration: 3.0)
//        let fadeIn = SKAction.fadeIn(withDuration: 3.0)
        let moveleft = SKAction.moveBy(x: -800, y: 0, duration: 1.0)
//        let waitAction = SKAction.wait(forDuration: 2.0)
        let moveback = SKAction.moveTo(x: 700, duration: 0.0)
        let sequence = SKAction.sequence([moveleft,moveback,moveleft])
        let sequence2 = SKAction.sequence([moveleft,moveleft, moveback])
        let sequence3 = SKAction.sequence([moveback,moveleft,moveleft,moveleft])
        let pulse = SKAction.repeatForever(sequence)
        let pulse2 = SKAction.repeatForever(sequence2)
        let pulse3 = SKAction.repeatForever(sequence3)
        belt.run(pulse)
        belt2.run(pulse2)
        belt3.run(pulse3)
        
        
        var motionManager = CMMotionManager()
        let opQueue = OperationQueue()
        
        func degrees(_ radians: Double) -> Double {
            return 180/Double.pi * radians
        }
        
        func startReadingMotionData() {
            // set read speed
            motionManager.deviceMotionUpdateInterval = 1
            // start reading
            motionManager.startDeviceMotionUpdates(to: opQueue) {
                (data: CMDeviceMotion?, error: Error?) in
                
                if let mydata = data {
                    print("mydata", mydata.gravity)
                    print("pitch raw", mydata.attitude.pitch)
                    print("pitch",  degrees(mydata.attitude.pitch))
                }
            }
        }
    

            if motionManager.isDeviceMotionAvailable {
                print("We can detect device motion")
                startReadingMotionData()
            }
            else {
                print("We cannot detect device motion")
            }

        
 
        
     
        
//        // Create shape node to use during mouse interaction
//        let w = (self.size.width + self.size.height) * 0.05
//        self.spinnyNode = SKShapeNode.init(rectOf: CGSize.init(width: w, height: w), cornerRadius: w * 0.3)
//
//        if let spinnyNode = self.spinnyNode {
//            spinnyNode.lineWidth = 2.5
//
//            spinnyNode.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(Double.pi), duration: 1)))
//            spinnyNode.run(SKAction.sequence([SKAction.wait(forDuration: 0.5),
//                                              SKAction.fadeOut(withDuration: 0.5),
//                                              SKAction.removeFromParent()]))
//        }
        
        
    }
    

    
    
    func touchDown(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.green
            self.addChild(n)
        }
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.blue
            self.addChild(n)
        }
    }
    
    func touchUp(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.red
            self.addChild(n)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let label = self.label {
            label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
        }
        
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
