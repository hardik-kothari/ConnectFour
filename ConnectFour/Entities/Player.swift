//
//  Player.swift
//  ConnectFour
//
//  Created by Hardik on 7/9/2561 BE.
//  Copyright © 2561 Hardik Kothari. All rights reserved.
//

import UIKit

class Player: NSObject {
    let id: Int
    var name: String
    let color: String
    var isBot: Bool = false
    
    init(id: Int, name: String, color: String, isBot: Bool) {
        self.id = id
        self.name = name
        self.color = color
        self.isBot = isBot
    }
}
