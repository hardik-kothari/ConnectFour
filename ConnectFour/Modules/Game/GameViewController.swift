//
//  GameViewController.swift
//  ConnectFour
//
//  Created by Hardik on 7/9/2561 BE.
//  Copyright © 2561 Hardik Kothari. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    // MARK: - IBOutlets -
    @IBOutlet weak var vwPlayersInfo: UIView!
    @IBOutlet weak var vwGridBoard: UIView!
    
    // MARK: - Public properties -
    let playersViewModule = PlayersViewWireframe()
    var gridBoardViewModule: GridBoardWireframe!
    
    // MARK: - Life cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        showProgressView()
        playersViewModule.moduleView.frame = vwPlayersInfo.bounds
        playersViewModule.moduleView.alpha = 0
        vwPlayersInfo.addSubview(playersViewModule.moduleView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addObservers()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
        NotificationCenter.default.removeObserver(playersViewModule.moduleView)
    }
    
    // MARK: - Notification Observer Methods
    func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(didRecieveConfiguration), name: Notification.Name("didRecieveConfiguration"), object: nil)
        NotificationCenter.default.addObserver(playersViewModule.moduleView, selector: #selector(PlayersView.didSwitchPlayer), name: Notification.Name("didSwitchPlayer"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didFinishGame), name: Notification.Name("didFinishGame"), object: nil)
    }
    
    @objc func didRecieveConfiguration(_ notification: Notification) {
        if let players = notification.object as? (player1: Player, player2: Player) {
            playersViewModule.moduleView.alpha = 1
            if tabBarController?.selectedIndex == 1 {
                players.player2.isBot = true
            }
            gridBoardViewModule = GridBoardWireframe(players: players)
            gridBoardViewModule.moduleView.frame = vwGridBoard.bounds
            vwGridBoard.addSubview(gridBoardViewModule.moduleView)
        }
        if let error = notification.object as? Error {
            let alert = UIAlertController(title: "Connect Four", message: error.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        hideProgressView()
    }
    
    @objc func didFinishGame(_ notification: Notification) {
        var winTitle: String = "Game Over"
        let winMessage: String = "Would you like to play again?"
        if let winner = notification.object as? Player {
            winTitle = "\(winner.name!) wins!"
        }
        let alert = UIAlertController(title: winTitle, message: winMessage, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Play Again", style: .default, handler: { action in
            switch action.style {
            case .default:
                self.gridBoardViewModule.resetGame()
            case .cancel:
                print("cancel")
            case .destructive:
                print("destructive")
        }}))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
