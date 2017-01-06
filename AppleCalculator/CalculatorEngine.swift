//
//  CalculatorEngine.swift
//  AppleCalculator
//
//  Created by Rasmus Gulbaek on 28/11/2016.
//  Copyright © 2016 Gulbaek I/S. All rights reserved.
//

import Foundation
import SpriteKit

public class AppleTree {
    var leftAppleCount = 0.0
    var rightAppleCount = 0.0
    var resultValue = 0.0
    var waitResultCounter = 0.0
    
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
    
    func incrementLeftAppleCount(){
        leftAppleCount += 1
    }
    func incrementRightAppleCount(){
        rightAppleCount += 1
    }
    
    func plus(){
        resultValue = leftAppleCount + rightAppleCount
    }
    
    func minus(){
        resultValue = leftAppleCount - rightAppleCount
    }
    
    func multiply(){
        resultValue = leftAppleCount * rightAppleCount
    }
    
    func divide(){
        resultValue = round(10*(leftAppleCount / rightAppleCount))/10
    }
    
    func reset(){
        leftAppleCount = 0
        rightAppleCount = 0
        resultValue = 0
        waitResultCounter = 0
    }
    
    
}
