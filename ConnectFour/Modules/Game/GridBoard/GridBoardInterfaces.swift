//
//  GridBoardInterfaces.swift
//  ConnectFour
//
//  Created by Hardik on 8/9/2561 BE.
//  Copyright (c) 2561 Hardik Kothari. All rights reserved.
//

import UIKit

protocol GridBoardWireframeInterface: class {
}

protocol GridBoardViewInterface: class {
    func getColumnView(_ tag: Int) -> UIView
    func highlightWinSequence(_ winner: Player?, Sequence winSequence: [(row: Int, col: Int)]?)
    func resetGridBoard()
}

protocol GridBoardPresenterInterface: class {
    func addTapGestureToView(_ view: UIView)
    func resetGame()
}
