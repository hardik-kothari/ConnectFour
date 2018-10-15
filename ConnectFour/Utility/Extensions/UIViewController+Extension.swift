//
//  UIViewController+Extension.swift
//  ConnectFour
//
//  Created by Hardik on 11/9/2561 BE.
//  Copyright © 2561 Hardik Kothari. All rights reserved.
//

import UIKit
import MBProgressHUD

extension UIViewController {
    func showProgressView() {
        DispatchQueue.main.async(execute: {
            let hud = MBProgressHUD.showAdded(to: ((UIApplication.shared.delegate?.window)!)!, animated: true)
            hud.contentColor = UIColor.white
            hud.bezelView.alpha = 1.0
            hud.bezelView.color = UIColor.clear
            hud.bezelView.style = .solidColor
            hud.backgroundView.color = UIColor.black
            hud.backgroundView.alpha = 0.6
            hud.backgroundView.style = .solidColor
        })
    }
    
    func hideProgressView() {
        DispatchQueue.main.async(execute: {
            MBProgressHUD.hide(for: ((UIApplication.shared.delegate?.window)!)!, animated: true)
        })
    }
}
