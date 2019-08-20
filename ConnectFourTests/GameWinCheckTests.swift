//
//  GameWinCheckTests.swift
//  ConnectFourTests
//
//  Created by Hardik on 11/9/2561 BE.
//  Copyright © 2561 Hardik Kothari. All rights reserved.
//

import XCTest
@testable import ConnectFour

class GameWinCheckTests: XCTestCase {
    
    func testHorizontalGameWinFound() {
        let connectMatrix = [
            [0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0],
            [0, 0, 2, 0, 2, 2, 0],
            [2, 1, 2, 1, 1, 1, 1],
            [1, 2, 1, 2, 1, 2, 1]
        ]
        let winSequence = GameWinChacker.findGameWinSequence(connectMatrix)
        XCTAssertTrue(winSequence != nil)
    }

    func testVerticalGameWinFound() {
        let connectMatrix = [
            [0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 1, 0, 2, 0],
            [0, 0, 2, 1, 2, 2, 0],
            [2, 1, 2, 1, 1, 2, 1],
            [1, 2, 1, 2, 1, 2, 1]
        ]
        let winSequence = GameWinChacker.findGameWinSequence(connectMatrix)
        XCTAssertTrue(winSequence != nil)
    }
    
    func testDiagonalGameWinFound() {
        let connectMatrix = [
            [0, 0, 0, 0, 0, 0, 0],
            [0, 1, 0, 0, 0, 0, 0],
            [0, 2, 1, 1, 0, 2, 0],
            [0, 0, 2, 1, 2, 1, 0],
            [2, 1, 2, 1, 1, 2, 2],
            [1, 2, 1, 2, 1, 2, 1]
        ]
        let winSequence = GameWinChacker.findGameWinSequence(connectMatrix)
        XCTAssertTrue(winSequence != nil)
    }
    
    func testGameWinSequenceNotFoundAtAll() {
        let connectMatrix = [
            [0, 0, 0, 0, 0, 0, 0],
            [0, 1, 0, 0, 0, 0, 0],
            [0, 1, 2, 1, 0, 2, 0],
            [0, 0, 2, 1, 2, 1, 0],
            [2, 1, 2, 1, 1, 2, 2],
            [1, 2, 1, 2, 1, 2, 1]
        ]
        let winSequence = GameWinChacker.findGameWinSequence(connectMatrix)
        XCTAssertTrue(winSequence == nil)
    }
}
