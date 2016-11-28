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
    //var graphs = [String : GKGraph]()
    
    private var lastUpdateTime : TimeInterval = 0
    private var resultLabel : SKLabelNode?
    
    var resultApples: [SKSpriteNode] = []
    
    private var apple : SKSpriteNode?
    private var apple1 : SKSpriteNode?
    private var apple10 : SKSpriteNode?
    private var spinnyNode : SKShapeNode?
    
    let appleTree = AppleTree()
    //let resultLabel = ResultLabel(self)
    
    //var apple: SKSpriteNode?
    
    override func sceneDidLoad() {

        self.lastUpdateTime = 0
        
        
        //resultLabel.updateResultLabel()
        
        //TODO main setup
        //label = self.childNode(withName: "Result") as? SKLabelNode
        //label?.text = String(result.iResult)
        
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
    
    func updateResultLabel(){
        resultLabel = self.childNode(withName: "Result") as? SKLabelNode
        resultLabel?.text = String(appleTree.resultValue)
    }
    func clearResultLabel(){
        resultLabel = self.childNode(withName: "Result") as? SKLabelNode
        resultLabel?.text = ""
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
                    appleTree.incrementLeftAppleCount()
                    
                    
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
                    appleTree.incrementRightAppleCount()
                    
                    
                    apple = self.childNode(withName: nodeName) as? SKSpriteNode
                    apple?.position = CGPoint(x: 230, y: 100)
                    apple?.physicsBody?.affectedByGravity = true
                }
                else if  nodeName == "Plus"
                {
                    appleTree.plus()
                    
                    

                    // Setup leftApples
//                    for child in self.children {
//                        if child.name == "Left_Apple" {
//                            if let child = child as? SKSpriteNode {
//                                leftApples.append(child)
//                            }
//                        }
//                    }
                    
//                    for apple in resultApples {
//                        apple.position = CGPoint(x: -213, y: 381)
//                        apple.physicsBody?.affectedByGravity = false
//                    }
                    
                    apple = self.childNode(withName: "Left_Apple_1") as? SKSpriteNode
                    apple?.position = CGPoint(x: -213, y: 381)
                    apple?.physicsBody?.affectedByGravity = false
                    
                    
                    apple = self.childNode(withName: "Left_Apple_2") as? SKSpriteNode
                    apple?.position = CGPoint(x: -106, y: 475)
                    apple?.physicsBody?.affectedByGravity = false
                    
                    apple = self.childNode(withName: "Left_Apple_3") as? SKSpriteNode
                    apple?.position = CGPoint(x: -128, y: 495)
                    apple?.physicsBody?.affectedByGravity = false

                    //TODO tilføj physbody
                    //apple = self.childNode(withName: "TopDoor") as? SKSpriteNode
                    //apple?.position = CGPoint(x: -8, y: 34)
                    //apple?.addChild(scene!)
                }
                else if  nodeName == "Equal"
                {
                    apple = self.childNode(withName: "TopDoor") as? SKSpriteNode
                    apple?.removeFromParent()
                    
                    addResultApple()
                    //addResultApple()
                    //addResultApple()
                    
                    
                    
                    if let label = self.resultLabel {
                        label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
                    }
                    updateResultLabel()
                }
                else if  nodeName == "Clear"
                {
                    //TODO reset Apples
                    appleTree.reset()
                    clearResultLabel()
                }
            }
        }
        
        
        
        //print("nodeAtPoint.name: " + nodeAtPoint.name! )
        //print(nodesAtPoint.count )
        
//        if let label = self.resultLabel {
//            label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
//        }
        
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
    
    func addResultApple() {
        // Create sprite
        
        
        let resultApple = SKSpriteNode(imageNamed: "Apple")
        
        
        resultApple.size.height = 40
        resultApple.size.width = 40
        resultApple.physicsBody = SKPhysicsBody(circleOfRadius: resultApple.size.width/2) // 1
        resultApple.physicsBody?.categoryBitMask = 1 // 3
        resultApple.physicsBody?.collisionBitMask = 4294967295 // 5
        resultApple.physicsBody?.fieldBitMask = 4294967295
        resultApple.physicsBody?.contactTestBitMask = 0
        resultApple.name = "ResultApple"
        resultApple.physicsBody?.affectedByGravity = true
        
        resultApple.physicsBody?.isDynamic = true
        
        resultApple.physicsBody?.friction = 0
        resultApple.physicsBody?.mass = 0.05
        
        resultApple.physicsBody?.allowsRotation = true
                
        resultApple.position = CGPoint(x: 0, y: -341)
        
        resultApple.zPosition = 10
        
        // Add the meteor to the scene
        addChild(resultApple)
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
