//
//  NetworkConfiguration.swift
//  ConnectFour
//
//  Created by Hardik on 7/9/2561 BE.
//  Copyright © 2561 Hardik Kothari. All rights reserved.
//

import UIKit

class NetworkConfiguration: NSObject {
    var serverURL: String = ""
    
    // MARK: - Init
    fileprivate override init() {
        self.buildEnvironment = .production
        super.init()
    }
    
    class var sharedInstance: NetworkConfiguration {
        struct Static {
            static var instance: NetworkConfiguration?
        }
        if Static.instance == nil {
            Static.instance = NetworkConfiguration()
        }
        return Static.instance!
    }
    
    var buildEnvironment: BuildEnvironment {
        didSet {
            if buildEnvironment == .debug {
                serverURL = "http://private-anon-dc8af1d7f8-blinkist.apiary-proxy.com/connectFour/"
            } else if buildEnvironment == .mock {
                serverURL = "http://private-anon-dc8af1d7f8-blinkist.apiary-mock.com/connectFour/"
            } else if buildEnvironment == .production {
                serverURL = "http://blinkist.apiblueprint.org/connectFour/"
            }
        }
    }
}
