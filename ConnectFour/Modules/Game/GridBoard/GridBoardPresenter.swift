//
//  GridBoardPresenter.swift
//  ConnectFour
//
//  Created by Hardik on 8/9/2561 BE.
//  Copyright (c) 2561 Hardik Kothari. All rights reserved.
//

import UIKit

let maxColumns: Int = 7
let maxRows: Int = 6

final class GridBoardPresenter {

    // MARK: - Private properties -
    private unowned var _view: GridBoardViewInterface
    private var _wireframe: GridBoardWireframeInterface
    private var player1: Player
    private var player2: Player
    private var currentPlayer: Player
    private var currentToken: UIView!
    private var connectMatrix: [[Int]]
    private var droppedTokens: Int
    
    // MARK: - Initializers -
    init(wireframe: GridBoardWireframeInterface, view: GridBoardViewInterface, players: (player1: Player, player2: Player)) {
        _wireframe = wireframe
        _view = view
        player1 = players.player1
        player2 = players.player2
        currentPlayer = players.player1
        connectMatrix = [
            [0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0]
        ]
        droppedTokens = 0
        NotificationCenter.default.post(name: Notification.Name("didSwitchPlayer"), object: currentPlayer)
    }
    
    // MARK: - Gesture Recognizer -
    @objc func tapHandler(gesture: UITapGestureRecognizer) {
        if let tappedView = gesture.view {
            if tappedView.subviews.count == maxRows {
                return
            }
            if gesture.state == .began {
                currentToken = createTokenForCurrentPlayer(tappedView)
            } else if gesture.state == .ended {
                tappedView.superview?.isUserInteractionEnabled = false
                dropToken(currentToken, InColumn: tappedView, Completion: { (_) in
                    self.saveTokenPositionInMatrix(tappedView)
                    tappedView.superview?.isUserInteractionEnabled = true
                })
            }
        }
    }

    // MARK: - Game Logic Methods -
    func createTokenForCurrentPlayer(_ columnView: UIView) -> UIView {
        let tokenViewSize: CGFloat = columnView.frame.size.width
        let tokenView: UIView = UIView(frame: CGRect(x: 0, y: tokenViewSize * -1, width: tokenViewSize, height: tokenViewSize))
        let imgToken: UIImageView = UIImageView(image: #imageLiteral(resourceName: "token"))
        imgToken.contentMode = .scaleAspectFit
        let tokenSize: CGFloat = tokenViewSize - 6
        imgToken.backgroundColor = UIColor(hexString: currentPlayer.color)
        imgToken.frame = CGRect(x: 3, y: 3, width: tokenSize, height: tokenSize)
        imgToken.layer.cornerRadius = tokenSize / 2
        tokenView.addSubview(imgToken)
        return tokenView
    }
    
    func dropToken(_ tokenView: UIView, InColumn columnView: UIView, Completion completion: @escaping ((Bool)) -> Void) {
        columnView.addSubview(tokenView)
        UIView.animate(withDuration:0.4, animations: {
                        var frame: CGRect = tokenView.frame
                        frame.origin.y = columnView.frame.size.height - (CGFloat(columnView.subviews.count) * frame.size.height)
                        tokenView.frame = frame
        }, completion: nil)
        var dx: CGFloat = 0, dy: CGFloat = 0, ds: CGFloat = 0
        dx = 0
        dy = tokenView.bounds.size.height * -0.8;
        UIView.animateKeyframes(
            withDuration: 1.0, delay: 0.3, options: .calculationModeLinear, animations: {
                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.28) {
                    let t = CGAffineTransform(translationX: dx, y: dy)
                    tokenView.transform = t.scaledBy(x: 1 + ds, y: 1 + ds)
                }
                UIView.addKeyframe(withRelativeStartTime: 0.28, relativeDuration: 0.28) {
                    tokenView.transform = .identity
                }
                UIView.addKeyframe(withRelativeStartTime: 0.56, relativeDuration: 0.28) {
                    let t = CGAffineTransform(translationX: dx * 0.5, y: dy * 0.5)
                    tokenView.transform = t.scaledBy(x: 1 + ds * 0.5, y: 1 + ds * 0.2)
                }
                UIView.addKeyframe(withRelativeStartTime: 0.84, relativeDuration: 0.16) {
                    tokenView.transform = .identity
                }
        }, completion: completion)
    }
    
    func saveTokenPositionInMatrix(_ columnView: UIView) {
        let columnNumber: Int = columnView.tag - 100
        let rowNumber: Int = maxRows - columnView.subviews.count
        connectMatrix[rowNumber][columnNumber] = currentPlayer.id
        droppedTokens += 1
        checkIfGameIsOver()
    }
    
    func checkIfGameIsOver() {
        if droppedTokens >= 7 {
            if let winSequence = GameWinChacker.findGameWinSequence(connectMatrix) {
                let winnerId: Int = connectMatrix[winSequence[0].row][winSequence[0].col]
                var winner: Player = player1
                if winnerId != winner.id {
                    winner = player2
                }
                _view.highlightWinSequence(winner, Sequence: winSequence)
            } else {
                if droppedTokens == (maxRows * maxColumns) {
                    _view.highlightWinSequence(nil, Sequence: nil)
                } else {
                    togglePlayer()
                }
            }
        } else {
            togglePlayer()
        }
    }
    
    func togglePlayer() {
        currentPlayer = (currentPlayer == player2) ? player1 : player2
        currentToken = nil
        NotificationCenter.default.post(name: Notification.Name("didSwitchPlayer"), object: currentPlayer)
        if currentPlayer.isBot {
            playComputerMove()
        }
    }
    
    // MARK: - Bot Mode Logic -
    func playComputerMove() {
        var randomColumn: UIView = _view.getColumnView(getRandomNumber(maxColumns))
        while randomColumn.subviews.count == maxRows {
            randomColumn = _view.getColumnView(getRandomNumber(maxColumns))
        }
        currentToken = createTokenForCurrentPlayer(randomColumn)
        randomColumn.superview?.isUserInteractionEnabled = false
        dropToken(currentToken, InColumn: randomColumn, Completion: { (_) in
            self.saveTokenPositionInMatrix(randomColumn)
            randomColumn.superview?.isUserInteractionEnabled = true
        })
    }
    
    func getRandomNumber(_ maxNumber: Int) -> Int {
        return Int(arc4random_uniform(UInt32(maxNumber)))
    }
}

// MARK: - Extensions -
extension GridBoardPresenter: GridBoardPresenterInterface {
    func addTapGestureToView(_ view: UIView) {
        let tapGesture = UILongPressGestureRecognizer(target: self, action: #selector(tapHandler))
        tapGesture.minimumPressDuration = 0
        view.addGestureRecognizer(tapGesture)
    }
    
    func resetGame() {
        connectMatrix = [
            [0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0]
        ]
        droppedTokens = 0
        _view.resetGridBoard()
        if currentPlayer != player1 {
            currentPlayer = player1
            NotificationCenter.default.post(name: Notification.Name("didSwitchPlayer"), object: currentPlayer)
        }
    }
}
