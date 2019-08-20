//
//  PlayersViewInteractor.swift
//  ConnectFour
//
//  Created by Hardik on 8/9/2561 BE.
//  Copyright (c) 2561 Hardik Kothari. All rights reserved.
//

import Foundation

final class PlayersViewInteractor {
    var interactorOutput: PlayersViewInteractorOutput!
}

// MARK: - Extensions -
extension PlayersViewInteractor: PlayersViewInteractorInterface {
    
    func getPlayerDetails() {
        let player1 = Player(id: 1, name: "Hardik Kothari", color: "#0064C8", isBot: false)
        let player2 = Player(id: 2, name: "John", color: "#C81E73", isBot: false)
        DispatchQueue.main.async { [weak self] in
            self?.interactorOutput.didGetPlayerDetails(players: (player1, player2))
        }
    }
}
