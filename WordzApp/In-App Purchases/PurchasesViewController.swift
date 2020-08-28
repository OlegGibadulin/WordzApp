//
//  PurchaseViewController.swift
//  WordzApp
//
//  Created by Mac-HOME on 26.08.2020.
//  Copyright © 2020 Mac-HOME. All rights reserved.
//

import UIKit
import SwiftyStoreKit
import StoreKit

// TODO: some string from apple dev acc
var sharedSecret = "some string from apple dev acc"

enum RegisteredPurchase: String {
    // non-consumable in-app purchase
    case ProVersion = "ProVersion"
}

class PurchasesViewController: UIViewController {
    
    let appBundleId = "bundle id of project"
    
    var ProVersion = RegisteredPurchase.ProVersion

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func getInfo(_ purchase: RegisteredPurchase) {
        NetworkActivityIndicatorManager.networkOperationStarted()
        SwiftyStoreKit.retrieveProductsInfo([appBundleId + "." + purchase.rawValue]) { (result) in
            
            NetworkActivityIndicatorManager.networkOperationFinished()
            self.showAlert(self.alertForProductRetrievalInfo(result))
        }
    }
    
    func purchase(_ purchase: RegisteredPurchase) {
        NetworkActivityIndicatorManager.networkOperationStarted()
        SwiftyStoreKit.purchaseProduct(appBundleId + "." + purchase.rawValue) { (result) in
            
            NetworkActivityIndicatorManager.networkOperationFinished()
            
            if case .success(let purchase) = result {
                
                if purchase.productId == self.appBundleId + "." + "ProVersion" {
                    // TODO: unlock functions
                    print("It seems that you buy a pro version of app")
                }
                
                if purchase.needsFinishTransaction {
                    SwiftyStoreKit.finishTransaction(purchase.transaction)
                }
            }
            
            if let alert = self.alertForPurchaseResult(result) {
                self.showAlert(alert)
            }
        }
    }
    
    func restorePurchaces() {
        NetworkActivityIndicatorManager.networkOperationStarted()
        SwiftyStoreKit.restorePurchases { (results) in
            NetworkActivityIndicatorManager.networkOperationFinished()
            
            for purchase in results.restoredPurchases {
                if purchase.needsFinishTransaction {
                    // TODO: unlock functions
                    print("It seems that you already have a pro version of app")
                    SwiftyStoreKit.finishTransaction(purchase.transaction)
                }
            }
            self.showAlert(self.alertForRestorePurchases(results))
        }
    }
    
    func verifyReceipt() {
        NetworkActivityIndicatorManager.networkOperationStarted()
        verifyReceipt { result in
            NetworkActivityIndicatorManager.networkOperationFinished()
            self.showAlert(self.alertForVerifyReceipt(result))
        }
    }
    
    func verifyReceipt(completion: @escaping (VerifyReceiptResult) -> Void) {
        // TODO: your-shared-secret
        let appleValidator = AppleReceiptValidator(service: .production, sharedSecret: "your-shared-secret")
        SwiftyStoreKit.verifyReceipt(using: appleValidator, completion: completion)
    }
    
    func verifyPurchase(_ purchase: RegisteredPurchase) {
        NetworkActivityIndicatorManager.networkOperationStarted()
        verifyReceipt { result in
            NetworkActivityIndicatorManager.networkOperationFinished()

            switch result {
            case .success(let receipt):

                let productId = self.appBundleId + "." + purchase.rawValue
                
                if purchase == .ProVersion {
                    let purchaseResult = SwiftyStoreKit.verifyPurchase(productId: productId, inReceipt: receipt)
                    self.showAlert(self.alertForVerifyPurchase(purchaseResult, productId: productId))
                }
            case .error:
                self.showAlert(self.alertForVerifyReceipt(result))
            }
        }
    }

}
