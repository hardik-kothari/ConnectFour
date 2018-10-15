//
//  UIView+Extension.swift
//  ConnectFour
//
//  Created by Hardik on 10/9/2561 BE.
//  Copyright © 2561 Hardik Kothari. All rights reserved.
//

import UIKit

extension UIView {
    
    func highlight() {
        UIView.animateKeyframes(withDuration: 0.5, delay: 0.1, options: [.autoreverse, .repeat], animations: {
            self.alpha = 0.3
        }) { (completed) in
            self.alpha = 1.0
        }
    }
    
}
