//
//  PlayersViewPresenter.swift
//  ConnectFour
//
//  Created by Hardik on 8/9/2561 BE.
//  Copyright (c) 2561 Hardik Kothari. All rights reserved.
//

import UIKit

final class PlayersViewPresenter {

    // MARK: - Private properties -
    private unowned var _view: PlayersViewInterface
    private var _interactor: PlayersViewInteractorInterface
    private var _wireframe: PlayersViewWireframeInterface

    // MARK: - Lifecycle -
    init(wireframe: PlayersViewWireframeInterface, view: PlayersViewInterface, interactor: PlayersViewInteractorInterface) {
        _wireframe = wireframe
        _view = view
        _interactor = interactor
    }
}

// MARK: - Extensions -
extension PlayersViewPresenter: PlayersViewPresenterInterface {
    func getPlayerDetails() {
        _interactor.getPlayerDetails()
    }
}

extension PlayersViewPresenter: PlayersViewInteractorOutput {
    func didGetPlayerDetails(players: (player1: Player, player2: Player)) {
        _view.showPlayerDetails(player1: players.player1, player2: players.player2)
    }
    
    func didFailWithError(_ error: Error) {
        _view.showMessageForError(error: error)
    }
}
