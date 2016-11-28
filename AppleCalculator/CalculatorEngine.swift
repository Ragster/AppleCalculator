//
//  CalculatorEngine.swift
//  AppleCalculator
//
//  Created by Rasmus Gulbaek on 28/11/2016.
//  Copyright © 2016 Gulbaek I/S. All rights reserved.
//

import Foundation

class AppleTree {
    var leftAppleCount = 0
    var rightAppleCount = 0
    var resultValue = 0
    
    func incrementLeftAppleCount(){
        leftAppleCount += 1
    }
    func incrementRightAppleCount(){
        rightAppleCount += 1
    }
    
    func plus(){
        resultValue = leftAppleCount + rightAppleCount
    }
    
    func reset(){
        leftAppleCount = 0
        rightAppleCount = 0
        resultValue = 0
    }
    
    
}
