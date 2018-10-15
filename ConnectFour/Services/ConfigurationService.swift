//
//  ConfigurationService.swift
//  ConnectFour
//
//  Created by Hardik on 7/9/2561 BE.
//  Copyright © 2561 Hardik Kothari. All rights reserved.
//

import UIKit
import SwiftyJSON

class ConfigurationService: NSObject {
    
    class func getGameConfiguration(_ success: @escaping ((player1: Player, player2: Player)) -> Void, failure: @escaping (_ error: Error?) -> Void) {
        NetworkManager.sharedInstance.requestFor(path: "configuration", param: nil, httpMethod: .get, includeHeader: false, success: { (response) in
            let configuration = response[0]
            let player1: Player = Player()
            player1.id = 1
            player1.name = configuration["name1"].stringValue
            player1.color = configuration["color1"].stringValue
            let player2: Player = Player()
            player2.id = 2
            player2.name = configuration["name2"].stringValue
            player2.color = configuration["color2"].stringValue
            success((player1, player2))
        }) {(error) in
            failure(error)
        }
    }
    
}
