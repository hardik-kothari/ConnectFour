//
//  PlayersViewWireframe.swift
//  ConnectFour
//
//  Created by Hardik on 8/9/2561 BE.
//  Copyright (c) 2561 Hardik Kothari. All rights reserved.
//

import UIKit

final class PlayersViewWireframe {

    // MARK: - Public Properties -
    var moduleView: PlayersView!
    
    // MARK: - Module setup -
    init() {
        let xib = UINib(nibName: "PlayersView", bundle: nil)
        let array:[Any] = xib.instantiate(withOwner: nil, options: nil)
        if let module = array.first as? PlayersView {
            moduleView = module
        }

        let interactor = PlayersViewInteractor()
        let presenter = PlayersViewPresenter(wireframe: self, view: moduleView, interactor: interactor)
        interactor.interactorOutput = presenter
        moduleView.presenter = presenter
    }
}

// MARK: - Extensions -
extension PlayersViewWireframe: PlayersViewWireframeInterface {
}
