//
//  GameScene.swift
//  AppleCalculator
//
//  Created by Rasmus Gulbaek on 21/10/2016.
//  Copyright © 2016 Gulbaek I/S. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var entities = [GKEntity]()
    //var graphs = [String : GKGraph]()
    
    private var lastUpdateTime : TimeInterval = 0
    private var resultLabel : SKLabelNode?
    
    var resultApples: [SKSpriteNode] = []
    var operandChoosen = ""
    
    var topDoor : SKSpriteNode?
    private var apple : SKSpriteNode?
    private var operand : SKSpriteNode?
    private var label : SKLabelNode?
    
    private var spinnyNode : SKShapeNode?
    
    let appleTree = AppleTree()
    //let resultLabel = ResultLabel(self)
    
    //var apple: SKSpriteNode?
    
    override func sceneDidLoad() {

        self.lastUpdateTime = 0
        
        self.physicsWorld.contactDelegate = self
        
        clearResultLabel()
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
        
        label = self.childNode(withName: "LeftCounterLabel") as? SKLabelNode
        label?.text = ""
        
        label = self.childNode(withName: "RightCounterLabel") as? SKLabelNode
        label?.text = ""
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
    
    func resetApples(){
        var appleName = ""
        var appleCounter = 0
        
        let leftApplesPosition: [CGPoint] =
            [CGPoint(x: -265, y: 380),
             CGPoint(x: -189, y: 380),
             CGPoint(x: -113, y: 380),
             CGPoint(x: -265, y: 307),
             CGPoint(x: -189, y: 307),
             CGPoint(x: -111, y: 307),
             CGPoint(x: -265, y: 236),
             CGPoint(x: -189, y: 235),
             CGPoint(x: -113, y: 235),
             CGPoint(x: -113, y: 167)]
        
        let rightApplesPosition: [CGPoint] =
            [CGPoint(x: 76, y: 374),
             CGPoint(x: 152, y: 374),
             CGPoint(x: 229, y: 377),
             CGPoint(x: 77, y: 307),
             CGPoint(x: 153, y: 307),
             CGPoint(x: 228, y: 307),
             CGPoint(x: 76, y: 231),
             CGPoint(x: 152, y: 234),
             CGPoint(x: 228, y: 232),
             CGPoint(x: 229, y: 167)]
        
        for leftApple in leftApplesPosition {
            appleCounter += 1
            appleName = "Left_Apple_" + String(appleCounter)
            resetApple(atPoint: leftApple, with: (appleName))
        }
        
        appleCounter = 0
        for rightApple in rightApplesPosition {
            appleCounter += 1
            appleName = "Right_Apple_" + String(appleCounter)
            resetApple(atPoint: rightApple, with: (appleName))
        }
        resetTopDoor()
        
        while self.childNode(withName: "ResultApple") as? SKSpriteNode != nil {
            apple = self.childNode(withName: "ResultApple") as? SKSpriteNode
            apple?.removeFromParent()
        }
    }
    
    func resetTopDoor(){
        topDoor = self.childNode(withName: "TopDoor") as? SKSpriteNode
        
        topDoor?.physicsBody?.categoryBitMask = 2
        topDoor?.physicsBody?.collisionBitMask = 4294967295 // 5
        topDoor?.physicsBody?.fieldBitMask = 4294967295
        topDoor?.physicsBody?.contactTestBitMask = 1
        
        
    }
    
    func resetApple(atPoint pos: CGPoint, with name: String){
        apple = self.childNode(withName: name) as? SKSpriteNode
        apple?.position = pos
        apple?.physicsBody?.affectedByGravity = false
        apple?.physicsBody?.allowsRotation = false
        apple?.physicsBody?.angularVelocity = 0
        apple?.physicsBody?.isDynamic = false
    }
    
    func showCalculateOperand(withName name: String){
        operandChoosen = name
        
        operand = self.childNode(withName: "OperandPlus") as? SKSpriteNode
        operand?.zPosition = 10
        
        operand = self.childNode(withName: "OperandMinus") as? SKSpriteNode
        operand?.zPosition = 10
        
        operand = self.childNode(withName: "OperandMultiply") as? SKSpriteNode
        operand?.zPosition = 10
        
        operand = self.childNode(withName: "OperandDivide") as? SKSpriteNode
        operand?.zPosition = 10
        
        if(name != ""){
            operand = self.childNode(withName: name) as? SKSpriteNode
            operand?.zPosition = 14
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
                    
                    label = self.childNode(withName: "LeftCounterLabel") as? SKLabelNode
                    label?.text = String(format:"%.0f", appleTree.leftAppleCount)
                    
                    apple = self.childNode(withName: nodeName) as? SKSpriteNode
                    apple?.position = CGPoint(x: -230, y: 100)
                    apple?.physicsBody?.affectedByGravity = true
                    apple?.physicsBody?.allowsRotation = true
                    apple?.physicsBody?.isDynamic = true
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
                    
                    label = self.childNode(withName: "RightCounterLabel") as? SKLabelNode
                    label?.text = String(format:"%.0f", appleTree.rightAppleCount)
                    
                    apple = self.childNode(withName: nodeName) as? SKSpriteNode
                    apple?.position = CGPoint(x: 230, y: 100)
                    apple?.physicsBody?.affectedByGravity = true
                    apple?.physicsBody?.allowsRotation = true
                    apple?.physicsBody?.isDynamic = true
                }
                else if  nodeName == "Plus"
                {
                    showCalculateOperand(withName: "OperandPlus")
                }
                else if  nodeName == "Minus"
                {
                    showCalculateOperand(withName: "OperandMinus")
                }
                else if  nodeName == "Multiply"
                {
                    showCalculateOperand(withName: "OperandMultiply")
                }
                else if  nodeName == "Divide"
                {
                    showCalculateOperand(withName: "OperandDivide")
                }
                
                    
                else if  nodeName == "Equal"
                {
                    topDoor = self.childNode(withName: "TopDoor") as? SKSpriteNode
                    topDoor?.physicsBody?.categoryBitMask = 0
                    topDoor?.physicsBody?.collisionBitMask = 4294967295 // 5
                    topDoor?.physicsBody?.fieldBitMask = 4294967295
                    topDoor?.physicsBody?.contactTestBitMask = 0
                    
                    if(operandChoosen == "OperandPlus")
                    {
                        appleTree.plus()
                    }
                    else if(operandChoosen == "OperandMinus")
                    {
                        appleTree.minus()
                    }
                    else if(operandChoosen == "OperandMultiply")
                    {
                        appleTree.multiply()
                    }
                    else if(operandChoosen == "OperandDivide")
                    {
                        appleTree.divide()
                    }
                    
                    //TODO tilføj 0.1, 0.2, 0.3 .... 0.9 apple
                    var i = 0
                    while i < Int(appleTree.resultValue) {
                        addResultApple()
                        i += 1
                    }
                    
                    
                    updateResultLabel()
                    if let label = self.resultLabel {
                        label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
                    }
                }
                else if  nodeName == "Clear"
                {
                    //TODO reset ResultApples
                    resetApples()
                    appleTree.reset()
                    clearResultLabel()
                    showCalculateOperand(withName: "")
                    
                    
                    
                    
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
        
        let randomX:UInt32 = arc4random_uniform(4)
        
        resultApple.position = CGPoint(x: (Int(randomX) - 2), y: -341)
        
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
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        // 1
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        //print(firstBody.node?.name! ?? "test")
        //print(secondBody.node?.name! ?? "test")

        if(secondBody.node?.name == "resetBasket")
        {
            print("Jubii")
            print(firstBody.node?.name! ?? "test")
            print(secondBody.node?.name! ?? "test")
        }
        
        
//        if ((firstBody.categoryBitMask == PhysicsCategory.Meteor ) &&
//            (secondBody.categoryBitMask == PhysicsCategory.Player ))
//        {
//            meteorDidCollideWithPlayer(firstBody.node as! SKSpriteNode, player: secondBody.node as! SKSpriteNode)
//        }
//        if ((firstBody.categoryBitMask == PhysicsCategory.Meteor ) &&
//            (secondBody.categoryBitMask == PhysicsCategory.AsteroidWall ))
//        {
//            asteroidDidCollideWithAsteroidWall(secondBody.node as! SKSpriteNode, meteor: firstBody.node as! SKSpriteNode)
//        }
//        if ((firstBody.categoryBitMask == PhysicsCategory.Player ) &&
//            (secondBody.categoryBitMask == PhysicsCategory.BoosterLevel ))
//        {
//            print("boosterLevel Colide With Player")
//            boosterLevelDidCollideWithPlayer(secondBody.node as! SKSpriteNode, player: firstBody.node as! SKSpriteNode)
//        }
//        
        
        
    }

    
//    func didEnd(_ contact: SKPhysicsContact) {
//        var firstBody: SKPhysicsBody
//        var secondBody: SKPhysicsBody
//        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
//            firstBody = contact.bodyA
//            secondBody = contact.bodyB
//        } else {
//            firstBody = contact.bodyB
//            secondBody = contact.bodyA
//        }
//        print(firstBody)
//        print(secondBody)
////        if ((firstBody.categoryBitMask == PhysicsCategory.Meteor ) &&
////            (secondBody.categoryBitMask == PhysicsCategory.ScoreWall ))
////        {
////            asteroidDidCollideWithScoreWall(secondBody.node as! SKSpriteNode, meteor: firstBody.node as! SKSpriteNode)
////        }
//        
//    }
}
