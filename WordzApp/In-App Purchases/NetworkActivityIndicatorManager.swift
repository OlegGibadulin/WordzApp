//
//  NetworkActivityIndicatorManager.swift
//  WordzApp
//
//  Created by Mac-HOME on 28.08.2020.
//  Copyright © 2020 Mac-HOME. All rights reserved.
//

import UIKit

class NetworkActivityIndicatorManager: NSObject {
    
    private static var loadingCount = 0
    
    class func networkOperationStarted() {
        if loadingCount == 0 {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
        }
        loadingCount += 1
    }
    
    class func networkOperationFinished() {
        if loadingCount > 0 {
            loadingCount -= 1
        }
        
        if loadingCount == 0 {
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }
    }
    
}
