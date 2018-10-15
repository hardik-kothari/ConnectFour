//
//  NetworkManager.swift
//  ConnectFour
//
//  Created by Hardik on 7/9/2561 BE.
//  Copyright © 2561 Hardik Kothari. All rights reserved.
//

import UIKit
import Alamofire
import Reachability
import SwiftyJSON

class NetworkManager: NSObject {
    // MARK: - Variables
    static var isReachable: Bool = true
    fileprivate var reachability: Reachability?
    
    // MARK: - Initialize Methods
    class var sharedInstance: NetworkManager {
        struct Static {
            static var instance: NetworkManager?
        }
        if Static.instance == nil {
            Static.instance = NetworkManager()
        }
        return Static.instance!
    }
    
    override init() {
        super.init()
        reachability = Reachability.init()
        NotificationCenter.default.addObserver(self, selector: #selector(self.reachabilityChanged(_:)), name: Notification.Name.reachabilityChanged, object: reachability)
        do {
            try reachability!.startNotifier()
        } catch {
        }
    }
    
    // MARK: - Request Method
    func requestFor(path: String, param: [String: Any]?, httpMethod: HTTPMethod, includeHeader: Bool, success:@escaping (_ response: JSON) -> Void, failure:@escaping (_ error: Error?) -> Void) {
        
        let completeURL = NetworkConfiguration.sharedInstance.serverURL + path
        var headerParam: HTTPHeaders?
        if includeHeader {
            headerParam = ["Content-Type": "application/json",
                           "Accept": "application/json"
            ]
        }
        if NetworkManager.isReachable {
            Alamofire.request(completeURL, method: httpMethod, parameters: param, encoding: JSONEncoding.default, headers: headerParam).responseJSON { response in
                switch response.result {
                case .success:
                    if let responseDict = response.result.value {
                        success(JSON(responseDict))
                    } else {
                        failure(response.result.error)
                    }
                case .failure:
                    failure(response.result.error)
                }
            }
        } else {
            let error = NSError(domain: "No internet connection.", code: 9999, userInfo: nil)
            failure(error)
        }
    }
    
    // MARK: - Rechability
    @objc func reachabilityChanged(_ notification: Notification) {
        if let reachability = notification.object as? Reachability, reachability.connection != .none {
            NetworkManager.isReachable = true
            if reachability.connection == .wifi {
                print("Reachable via WiFi")
            } else {
                print("Reachable via Cellular")
            }
        } else {
            NetworkManager.isReachable = false
        }
    }
}
