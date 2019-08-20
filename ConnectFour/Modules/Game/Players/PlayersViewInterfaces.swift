//
//  PlayersViewInterfaces.swift
//  ConnectFour
//
//  Created by Hardik on 8/9/2561 BE.
//  Copyright (c) 2561 Hardik Kothari. All rights reserved.
//

import UIKit

protocol PlayersViewWireframeInterface: class {
}

protocol PlayersViewInterface: class {
    func showPlayerDetails(player1: Player, player2: Player)
    func showMessageForError(error: Error)
}

protocol PlayersViewPresenterInterface: class {
    func getPlayerDetails()
}

protocol PlayersViewInteractorInterface: class {
    func getPlayerDetails()
}

protocol PlayersViewInteractorOutput: class {
    func didGetPlayerDetails(players: (player1: Player, player2: Player))
    func didFailWithError(_ error: Error)
}
