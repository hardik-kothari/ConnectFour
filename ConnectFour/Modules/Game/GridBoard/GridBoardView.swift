//
//  GridBoardViewController.swift
//  ConnectFour
//
//  Created by Hardik on 8/9/2561 BE.
//  Copyright (c) 2561 Hardik Kothari. All rights reserved.
//

import UIKit

final class GridBoardView: UIView {
    
    // MARK: - IBOutlets -
    @IBOutlet weak var vwColumn1: UIView!
    @IBOutlet weak var vwColumn2: UIView!
    @IBOutlet weak var vwColumn3: UIView!
    @IBOutlet weak var vwColumn4: UIView!
    @IBOutlet weak var vwColumn5: UIView!
    @IBOutlet weak var vwColumn6: UIView!
    @IBOutlet weak var vwColumn7: UIView!
    
    // MARK: - Public properties -
    var presenter: GridBoardPresenterInterface!
    
    // MARK: - Initializers
    override public init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        presenter.addTapGestureToView(vwColumn1)
        presenter.addTapGestureToView(vwColumn2)
        presenter.addTapGestureToView(vwColumn3)
        presenter.addTapGestureToView(vwColumn4)
        presenter.addTapGestureToView(vwColumn5)
        presenter.addTapGestureToView(vwColumn6)
        presenter.addTapGestureToView(vwColumn7)
    }
}

// MARK: - Extensions -
extension GridBoardView: GridBoardViewInterface {
    func getColumnView(_ tag: Int) -> UIView {
        return self.viewWithTag(tag + 100)!
    }
    
    func resetGridBoard() {
        for column in 0..<maxColumns {
            if let columnView = self.viewWithTag(column + 100) {
                if columnView.isKind(of: UIView.self) {
                    for subView in columnView.subviews {
                        subView.removeFromSuperview()
                    }
                }
            }
        }
    }
    
    func highlightWinSequence(_ winner: Player?, Sequence winSequence: [(row: Int, col: Int)]?) {
        if let sequence = winSequence {
            for position in sequence {
                if let columnView = self.viewWithTag(position.col + 100) {
                    if columnView.isKind(of: UIView.self) {
                        let tokenIndex = maxRows - position.row - 1
                        if tokenIndex < columnView.subviews.count {
                            let tokenView = columnView.subviews[tokenIndex]
                            tokenView.highlight()
                        }
                    }
                }
            }
        }
        NotificationCenter.default.post(name: Notification.Name("didFinishGame"), object: winner)
    }
}
