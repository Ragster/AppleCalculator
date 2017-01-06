//
//  AppleCalculatorTests.swift
//  AppleCalculatorTests
//
//  Created by Rasmus Gulbaek on 21/10/2016.
//  Copyright © 2016 Gulbaek I/S. All rights reserved.
//

import XCTest
@testable import AppleCalculator

class AppleCalculatorTests: XCTestCase {
    
    let appleTree = AppleTree()
    
    override func setUp() {
        super.setUp()
        
        appleTree.reset()
        
        for _ in 0..<10
        {
            self.appleTree.incrementLeftAppleCount()
            self.appleTree.incrementRightAppleCount()
        }
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testPlus() {
        self.appleTree.plus()
        
        XCTAssert(self.appleTree.resultValue == 20)
    }
    
    func testMinus() {
        self.appleTree.minus()
        
        XCTAssert(self.appleTree.resultValue == 0)
    }
    
    func testMultiply() {
        self.appleTree.multiply()
        
        XCTAssert(self.appleTree.resultValue == 100)
    }
    
    func testDivide() {
        self.appleTree.divide()
        
        XCTAssert(self.appleTree.resultValue == 1)
    }
    

    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {

            for _ in 0..<10000
            {
                self.testPlus()
                self.testMinus()
                self.testMultiply()
                self.testDivide()
            }

        }
    }
    
}
