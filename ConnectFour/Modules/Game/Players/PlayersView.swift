//
//  PlayersViewViewController.swift
//  ConnectFour
//
//  Created by Hardik on 8/9/2561 BE.
//  Copyright (c) 2561 Hardik Kothari. All rights reserved.
//

import UIKit

final class PlayersView: UIView {
    
    // MARK: - IBOutlets -
    @IBOutlet weak var vwPlayer1: UIView!
    @IBOutlet weak var lblPlayer1: UILabel!
    @IBOutlet weak var vwPlayer2: UIView!
    @IBOutlet weak var lblPlayer2: UILabel!
    
    // MARK: - Public properties -
    var presenter: PlayersViewPresenterInterface!
    
    // MARK: - Initializers
    override public init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        presenter.getPlayerDetails()
    }
    
    // MARK: - Notification Observer Methods
    @objc func didSwitchPlayer(_ notification: Notification) {
        if let currentPlayer = notification.object as? Player {
            flashPlayer(currentPlayer)
        }
    }
    
    // MARK: - User defined Methods
    func flashPlayer(_ currentPlayer: Player) {
        vwPlayer1.alpha = 0.2
        vwPlayer2.alpha = 0.2
        var viewToFlash: UIView = vwPlayer1
        if currentPlayer.id == 1 {
            viewToFlash = vwPlayer1
        } else {
            viewToFlash = vwPlayer2
        }
        viewToFlash.alpha = 1.0
    }
}

// MARK: - Extensions -
extension PlayersView: PlayersViewInterface {
    
    func showPlayerDetails(player1: Player, player2: Player) {
        vwPlayer1.backgroundColor = UIColor(hexString: player1.color)
        lblPlayer1.text = player1.name
        vwPlayer2.backgroundColor = UIColor(hexString: player2.color)
        lblPlayer2.text = player2.name
        NotificationCenter.default.post(name: Notification.Name("didRecieveConfiguration"), object: (player1, player2))
    }

    func showMessageForError(error: Error) {
        NotificationCenter.default.post(name: Notification.Name("didRecieveConfiguration"), object: error)
    }
}
