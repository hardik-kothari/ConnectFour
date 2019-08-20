//
//  GridBoardWireframe.swift
//  ConnectFour
//
//  Created by Hardik on 8/9/2561 BE.
//  Copyright (c) 2561 Hardik Kothari. All rights reserved.
//

import UIKit

final class GridBoardWireframe {

    // MARK: - Public Properties -
    var moduleView: GridBoardView!

    // MARK: - Module setup -
    init(players: (player1: Player, player2: Player)) {
        let xib = UINib(nibName: "GridBoardView", bundle: nil)
        let array:[Any] = xib.instantiate(withOwner: nil, options: nil)
        moduleView = array.first as? GridBoardView
        
        let presenter = GridBoardPresenter(wireframe: self, view: moduleView, players: players)
        moduleView.presenter = presenter
    }
    
    func resetGame() {
        moduleView.presenter.resetGame()
    }
}

// MARK: - Extensions -
extension GridBoardWireframe: GridBoardWireframeInterface {
}
