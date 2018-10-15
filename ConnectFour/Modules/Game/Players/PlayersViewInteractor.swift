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
        ConfigurationService.getGameConfiguration({ (players) in
            self.interactorOutput.didGetPlayerDetails(players: players)
        }) { (error) in
            self.interactorOutput.didFailWithError(error!)
        }
    }
    
}
