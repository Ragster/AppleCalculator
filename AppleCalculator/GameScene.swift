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
    
    override func sceneDidLoad() {

        self.lastUpdateTime = 0
        
        self.physicsWorld.contactDelegate = self
        
        clearResultLabel()
        
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
        
        for leftApple in appleTree.leftApplesPosition {
            appleCounter += 1
            appleName = "Left_Apple_" + String(appleCounter)
            resetApple(atPoint: leftApple, with: (appleName))
        }
        
        appleCounter = 0
        for rightApple in appleTree.rightApplesPosition {
            appleCounter += 1
            appleName = "Right_Apple_" + String(appleCounter)
            resetApple(atPoint: rightApple, with: (appleName))
        }
        resetTopDoor()
        
        resetResultApples()
    }
    
    func resetResultApples(){
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
        apple?.zPosition = 10
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

        let location: CGPoint! = touch!.location(in: scene!)

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
                    if((apple?.position.y)! > CGFloat(166.0))
                    {
                    
                        apple?.position = CGPoint(x: -230, y: 100)
                        apple?.physicsBody?.affectedByGravity = true
                        apple?.physicsBody?.allowsRotation = true
                        apple?.physicsBody?.isDynamic = true
                    
                        appleTree.incrementLeftAppleCount()
                    
                        label = self.childNode(withName: "LeftCounterLabel") as? SKLabelNode
                        label?.text = String(format:"%.0f", appleTree.leftAppleCount)
                    }
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
                    if((apple?.position.y)! > CGFloat(166.0))
                    {
                        apple?.position = CGPoint(x: 230, y: 100)
                        apple?.physicsBody?.affectedByGravity = true
                        apple?.physicsBody?.allowsRotation = true
                        apple?.physicsBody?.isDynamic = true
                    
                        appleTree.incrementRightAppleCount()
                    
                        label = self.childNode(withName: "RightCounterLabel") as? SKLabelNode
                        label?.text = String(format:"%.0f", appleTree.rightAppleCount)
                    }
                    
                    
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
                    if(operandChoosen != "")
                    {
                        resetResultApples()
                    
                        topDoor = self.childNode(withName: "TopDoor") as? SKSpriteNode
                        topDoor?.physicsBody?.categoryBitMask = 0
                        topDoor?.physicsBody?.collisionBitMask = 4294967295
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
                    }
                    else
                    {
                        //Should i put a text telling to choose operation..?
                    }
                }
                else if  nodeName == "Clear"
                {
                    resetApples()
                    appleTree.reset()
                    clearResultLabel()
                    showCalculateOperand(withName: "")
                 }
            }
        }
    }
    
    func addResultApple() {
        // Create sprite
        let resultApple = SKSpriteNode(imageNamed: "Apple")
        
        if(appleTree.resultValue > 80)
        {
            resultApple.size.height = 19
            resultApple.size.width = 19
        }
        else if(appleTree.resultValue > 70)
        {
            resultApple.size.height = 22
            resultApple.size.width = 22
        }
        else if(appleTree.resultValue > 60)
        {
            resultApple.size.height = 23
            resultApple.size.width = 23
        }
        else if(appleTree.resultValue > 50)
        {
            resultApple.size.height = 25
            resultApple.size.width = 25
        }
        else if(appleTree.resultValue > 40)
        {
            resultApple.size.height = 27
            resultApple.size.width = 27
        }
        else if(appleTree.resultValue > 30)
        {
            resultApple.size.height = 30
            resultApple.size.width = 30
        }
        else
        {
            resultApple.size.height = 40
            resultApple.size.width = 40
        }
        
        resultApple.physicsBody = SKPhysicsBody(circleOfRadius: resultApple.size.width/2)
        resultApple.physicsBody?.categoryBitMask = 1
        resultApple.physicsBody?.collisionBitMask = 4294967295
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
        
        addChild(resultApple)
    }
    
    func addResultApple_0_25() {
        // Create sprite
        
        let resultAppleTexture = SKTexture(imageNamed: "Apple_0_25")
        let resultApple = SKSpriteNode(texture: resultAppleTexture)
        
        resultApple.size.height = 20
        resultApple.size.width = 20
        
        resultApple.physicsBody = SKPhysicsBody(texture: resultAppleTexture,
                      size: CGSize(width: resultApple.size.width,
                                   height: resultApple.size.height))
        
        
        resultApple.physicsBody?.categoryBitMask = 1
        resultApple.physicsBody?.collisionBitMask = 4294967295
        resultApple.physicsBody?.fieldBitMask = 4294967295
        resultApple.physicsBody?.contactTestBitMask = 0
        resultApple.name = "ResultApple"
        resultApple.physicsBody?.affectedByGravity = true
        
        resultApple.physicsBody?.isDynamic = true
        
        resultApple.physicsBody?.friction = 0
        resultApple.physicsBody?.mass = 0.05
        
        resultApple.physicsBody?.allowsRotation = true
        
        resultApple.physicsBody?.angularVelocity = 2
        
        let randomX:UInt32 = arc4random_uniform(4)
        
        resultApple.position = CGPoint(x: (Int(randomX) - 2), y: -341)
        
        resultApple.zPosition = 10
        
        addChild(resultApple)
    }
    
    func addResultApple_0_5() {
        // Create sprite
        
        let resultAppleTexture = SKTexture(imageNamed: "Apple_0_5")
        let resultApple = SKSpriteNode(texture: resultAppleTexture)
        
        resultApple.size.height = 20
        resultApple.size.width = 40
        
        resultApple.physicsBody = SKPhysicsBody(texture: resultAppleTexture,
                                                size: CGSize(width: resultApple.size.width,
                                                             height: resultApple.size.height))
        
        
        resultApple.physicsBody?.categoryBitMask = 1
        resultApple.physicsBody?.collisionBitMask = 4294967295
        resultApple.physicsBody?.fieldBitMask = 4294967295
        resultApple.physicsBody?.contactTestBitMask = 0
        resultApple.name = "ResultApple"
        resultApple.physicsBody?.affectedByGravity = true
        
        resultApple.physicsBody?.isDynamic = true
        
        resultApple.physicsBody?.friction = 0
        resultApple.physicsBody?.mass = 0.05
        
        resultApple.physicsBody?.allowsRotation = true
        
        resultApple.physicsBody?.angularVelocity = 2
        
        let randomX:UInt32 = arc4random_uniform(4)
        
        resultApple.position = CGPoint(x: (Int(randomX) - 2), y: -341)
        
        resultApple.zPosition = 10
        
        addChild(resultApple)
    }
    
    func addResultApple_0_75() {
        // Create sprite
        
        let resultAppleTexture = SKTexture(imageNamed: "Apple_0_75")
        let resultApple = SKSpriteNode(texture: resultAppleTexture)
        
        resultApple.size.height = 40
        resultApple.size.width = 40
        
        resultApple.physicsBody = SKPhysicsBody(texture: resultAppleTexture,
                                                size: CGSize(width: resultApple.size.width,
                                                             height: resultApple.size.height))
        
        
        resultApple.physicsBody?.categoryBitMask = 1
        resultApple.physicsBody?.collisionBitMask = 4294967295
        resultApple.physicsBody?.fieldBitMask = 4294967295
        resultApple.physicsBody?.contactTestBitMask = 0
        resultApple.name = "ResultApple"
        resultApple.physicsBody?.affectedByGravity = true
        
        resultApple.physicsBody?.isDynamic = true
        
        resultApple.physicsBody?.friction = 0
        resultApple.physicsBody?.mass = 0.05
        
        resultApple.physicsBody?.allowsRotation = true
        
        resultApple.physicsBody?.angularVelocity = 2
        
        let randomX:UInt32 = arc4random_uniform(4)
        
        resultApple.position = CGPoint(x: (Int(randomX) - 2), y: -341)
        
        resultApple.zPosition = 10
        
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
    
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        if(secondBody.node?.name == "resetBasket" || secondBody.node?.name == "TubeRightSide" || secondBody.node?.name == "TubeLeftSide" || secondBody.node?.name == "removeApplePhysic")
        {
            
            if(firstBody.node?.name != "ResultApple")
            {
                
                var myAppleNr = firstBody.node?.name!.components(separatedBy: "_")
                
                firstBody.node?.physicsBody?.affectedByGravity = false
                firstBody.node?.physicsBody?.allowsRotation = false
                firstBody.node?.physicsBody?.angularVelocity = 1
                firstBody.node?.physicsBody?.isDynamic = false
                firstBody.node?.zPosition = 2
                
                let actionMove = SKAction.move(to: CGPoint(x: 200, y: (firstBody.node?.position.y.hashValue)!), duration: 1.0)
                
                
                if(myAppleNr?[0] == "Left")
                {
                    let actionResetMove = SKAction.move(to: appleTree.leftApplesPosition[Int((myAppleNr?[2])!)! - 1], duration: 1.0)
                    firstBody.node?.run(SKAction.sequence([actionMove, actionResetMove]))
                }
                else if(myAppleNr?[0] == "Right")
                {
                    let actionResetMove = SKAction.move(to: appleTree.rightApplesPosition[Int((myAppleNr?[2])!)! - 1], duration: 1.0)
                    firstBody.node?.run(SKAction.sequence([actionMove, actionResetMove]))
                }
                
                // ++ has been removed in Swift 3.0 so we use += 1
                appleTree.waitResultCounter += 1
                
                if((appleTree.leftAppleCount + appleTree.rightAppleCount) == appleTree.waitResultCounter)
                {
                    showResultApples()
                }
            }
        }
    }
    
    func showResultApples()
    {
        if(appleTree.resultValue < 1)
        {
            //Missing graphic for 0.1 apple to 0.9 so this will do for now :-)
            if(appleTree.resultValue < 0.5)
            {
                self.addResultApple_0_25()
            }
            else if(appleTree.resultValue < 0.75)
            {
                self.addResultApple_0_5()
            }
            else
            {
                self.addResultApple_0_75()
            }
        }
        else
        {
            self.addResultApple()
            
            let decimalResultValue = modf(appleTree.resultValue).1
            
            if(decimalResultValue > 0)
            {
                if(decimalResultValue < 0.5)
                {
                    self.addResultApple_0_25()
                }
                else if(decimalResultValue < 0.75)
                {
                    self.addResultApple_0_5()
                }
                else
                {
                    self.addResultApple_0_75()
                }
            }
        }
        
        
        
        
        apple = self.childNode(withName: "ResultApple") as? SKSpriteNode
        
        let delay = SKAction.wait(forDuration: 0.1)
        let a = SKAction.run({ self.addResultApple() })
        
        let sekvens = SKAction.sequence([delay, a])
        
        apple?.run(SKAction.repeat(sekvens, count: Int(appleTree.resultValue - 1)))
        
        updateResultLabel()
        if let label = self.resultLabel {
            label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
        }
    }
}
