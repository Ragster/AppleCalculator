//
//  GameScene.swift
//  AppleCalculator
//
//  Created by Rasmus Gulbaek on 21/10/2016.
//  Copyright © 2016 Gulbaek I/S. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    
    private var lastUpdateTime : TimeInterval = 0
    private var label : SKLabelNode?
    private var apple : SKSpriteNode?
    private var apple1 : SKSpriteNode?
    private var apple10 : SKSpriteNode?
    private var spinnyNode : SKShapeNode?
    
    //var apple: SKSpriteNode?
    
    override func sceneDidLoad() {

        self.lastUpdateTime = 0
        
        
        //TODO main setup
        label = self.childNode(withName: "Result") as? SKLabelNode
        label?.text = "2"
        
//        apple1 = self.childNode(withName: "Apple1") as? SKSpriteNode
//        apple1?.physicsBody?.affectedByGravity = true
//        
//        apple10 = self.childNode(withName: "Apple10") as? SKSpriteNode
//        apple10?.physicsBody?.affectedByGravity = true
        
        // Create shape node to use during mouse interaction
        let w = (self.size.width + self.size.height) * 0.05
        self.spinnyNode = SKShapeNode.init(rectOf: CGSize.init(width: w, height: w), cornerRadius: w * 0.3)
        
        if let spinnyNode = self.spinnyNode {
            spinnyNode.lineWidth = 2.5
            
            spinnyNode.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(M_PI), duration: 1)))
            spinnyNode.run(SKAction.sequence([SKAction.wait(forDuration: 0.5),
                                              SKAction.fadeOut(withDuration: 0.5),
                                              SKAction.removeFromParent()]))
        }
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

        let touch = touches.first as UITouch?
//        _ = touch!.location(in: self)
//
        let location: CGPoint! = touch!.location(in: scene!)
//        
//        let nodeAtPoint = self.atPoint(location)
//        let nodesAtPoint = self.nodes(at: location)
//        
        
        
        
//        let touch = touches.anyObject() as UITouch
//        let touchLocation = touch.locationInNode(self)
        let nodes = self.nodes(at: location) as [SKNode]
        
        for node in nodes {
            if let nodeName = node.name {
                if  nodeName == "Left_Apple_1" ||
                    nodeName == "Left_Apple_2" ||
                    nodeName == "Left_Apple_3" ||
                    nodeName == "Left_Apple_4" ||
                    nodeName == "Left_Apple_5" ||
                    nodeName == "Left_Apple_6" ||
                    nodeName == "Left_Apple_7" ||
                    nodeName == "Left_Apple_8" ||
                    nodeName == "Left_Apple_9" ||
                    nodeName == "Left_Apple_10"
                {
                    
                    
                    apple = self.childNode(withName: nodeName) as? SKSpriteNode
                    apple?.position = CGPoint(x: -230, y: 100)
                    apple?.physicsBody?.affectedByGravity = true
                }
                else if  nodeName == "Right_Apple_1" ||
                    nodeName == "Right_Apple_2" ||
                    nodeName == "Right_Apple_3" ||
                    nodeName == "Right_Apple_4" ||
                    nodeName == "Right_Apple_5" ||
                    nodeName == "Right_Apple_6" ||
                    nodeName == "Right_Apple_7" ||
                    nodeName == "Right_Apple_8" ||
                    nodeName == "Right_Apple_9" ||
                    nodeName == "Right_Apple_10"
                {
                    
                    
                    apple = self.childNode(withName: nodeName) as? SKSpriteNode
                    apple?.position = CGPoint(x: 230, y: 100)
                    apple?.physicsBody?.affectedByGravity = true
                }
                else if  nodeName == "Plus"
                {
                    apple = self.childNode(withName: "Left_Apple_1") as? SKSpriteNode
                    apple?.position = CGPoint(x: -213, y: 381)
                    apple?.physicsBody?.affectedByGravity = false
                    
                    
                    apple = self.childNode(withName: "Left_Apple_2") as? SKSpriteNode
                    apple?.position = CGPoint(x: -106, y: 475)
                    apple?.physicsBody?.affectedByGravity = false
                    
                    apple = self.childNode(withName: "Left_Apple_3") as? SKSpriteNode
                    apple?.position = CGPoint(x: -128, y: 495)
                    apple?.physicsBody?.affectedByGravity = false


                }
                else if  nodeName == "Equal"
                {
                    apple = self.childNode(withName: "TopDoor") as? SKSpriteNode
                    apple?.removeFromParent()
                    
                    
                }
            }
        }
        
        
        
        //print("nodeAtPoint.name: " + nodeAtPoint.name! )
        //print(nodesAtPoint.count )
        
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
        
        // Initialize _lastUpdateTime if it has not already been
        if (self.lastUpdateTime == 0) {
            self.lastUpdateTime = currentTime
        }
        
        // Calculate time since last update
        let dt = currentTime - self.lastUpdateTime
        
        // Update entities
        for entity in self.entities {
            entity.update(deltaTime: dt)
        }
        
        self.lastUpdateTime = currentTime
    }
}
