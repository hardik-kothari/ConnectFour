//
//  GameWinChacker.swift
//  ConnectFour
//
//  Created by Hardik on 10/9/2561 BE.
//  Copyright © 2561 Hardik Kothari. All rights reserved.
//

import UIKit

class GameWinChacker: NSObject {

    class func findGameWinSequence(_ matrix: [[Int]]) -> [(row: Int, col: Int)]? {
        let numberOfRows: Int = matrix.count
        let numberOfColumns: Int = matrix[0].count
        if let horizontalSequence = findHorizontalSequence(matrix, numberOfRows: numberOfRows, numberOfColumns: numberOfColumns) {
            return horizontalSequence
        }
        if let verticalSequence = findVerticalSequence(matrix, numberOfRows: numberOfRows, numberOfColumns: numberOfColumns) {
            return verticalSequence
        }
        if let diagonalSequence = findDiagonalSequence(matrix, numberOfRows: numberOfRows, numberOfColumns: numberOfColumns) {
            return diagonalSequence
        }
        return nil
    }
    
    private class func findHorizontalSequence(_ matrix: [[Int]], numberOfRows: Int, numberOfColumns: Int) -> [(row: Int, col: Int)]? {
        for row in 0..<numberOfRows {
            for column in 0...(numberOfColumns - 4) {
                if matrix[row][column] != 0
                    && matrix[row][column] == matrix[row][column + 1]
                    && matrix[row][column] == matrix[row][column + 2]
                    && matrix[row][column] == matrix[row][column + 3] {
                    return [
                        (row, column),
                        (row, column + 1),
                        (row, column + 2),
                        (row, column + 3)
                    ]
                }
            }
        }
        return nil
    }
    
    private class func findVerticalSequence(_ matrix: [[Int]], numberOfRows: Int, numberOfColumns: Int) -> [(row: Int, col: Int)]? {
        for row in 0...(numberOfRows - 4) {
            for column in 0..<numberOfColumns {
                if matrix[row][column] != 0
                    && matrix[row][column] == matrix[row + 1][column]
                    && matrix[row][column] == matrix[row + 2][column]
                    && matrix[row][column] == matrix[row + 3][column] {
                    return [
                        (row, column),
                        (row + 1, column),
                        (row + 2, column),
                        (row + 3, column)
                    ]
                }
            }
        }
        return nil
    }

    private class func findDiagonalSequence(_ matrix: [[Int]], numberOfRows: Int, numberOfColumns: Int) -> [(row: Int, col: Int)]? {
        for column in 0...(numberOfColumns - 4) {
            for row in 0...(numberOfRows - 4) {
                if matrix[row][column] != 0
                    && matrix[row][column] == matrix[row + 1][column + 1]
                    && matrix[row][column] == matrix[row + 2][column + 2]
                    && matrix[row][column] == matrix[row + 3][column + 3] {
                    return [
                        (row, column),
                        (row + 1, column + 1),
                        (row + 2, column + 2),
                        (row + 3, column + 3)
                    ]
                }
            }
            for row in 3...(numberOfRows - 1) {
                if matrix[row][column] != 0
                    && matrix[row][column] == matrix[row - 1][column + 1]
                    && matrix[row][column] == matrix[row - 2][column + 2]
                    && matrix[row][column] == matrix[row - 3][column + 3] {
                    return [
                        (row, column),
                        (row - 1, column + 1),
                        (row - 2, column + 2),
                        (row - 3, column + 3)
                    ]
                }
            }
        }
        return nil
    }
}
