//
//  IAPService.swift
//  WordzApp
//
//  Created by Антон Тимонин on 27.09.2020.
//  Copyright © 2020 Mac-HOME. All rights reserved.
//

import Foundation
import StoreKit

class IAPService: NSObject {
    private override init() {}
    
    static let shared = IAPService()
    
    var myProduct = [SKProduct]()
    let paymentQueue = SKPaymentQueue.default()
    
    func getProducts() {
        let products: Set = [IAPProduct.removeAd.rawValue]
        let request = SKProductsRequest(productIdentifiers: products)
        request.delegate = self
        request.start()
        paymentQueue.add(self)
    }
    
    func purchase(product: IAPProduct) {
        guard let productToPurchase = myProduct.filter({ $0.productIdentifier == product.rawValue }).first else { return }
        if SKPaymentQueue.canMakePayments() {
            let payment = SKPayment(product: productToPurchase)
            paymentQueue.add(payment)
        }
        
    }
}

extension IAPService: SKProductsRequestDelegate {
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        myProduct = response.products
        if let product = response.products.first {
            print(product.productIdentifier)
            print(product.price)
            print(product.localizedTitle)
            print(product.localizedDescription)
        }
    }
}

extension IAPService: SKPaymentTransactionObserver {
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            switch transaction.transactionState {
            case .purchasing:
                print("purchasing")
                break
            case .purchased, .restored:
                Purchases.fullVersion = true
//                paymentQueue.finishTransaction(transaction)
                print("purchased or restored")
                break
            case .failed, .deferred:
//                paymentQueue.finishTransaction(transaction)
                print("failed or defferd")
                break
            default:
//                paymentQueue.finishTransaction(transaction)
                print("default")
                break
            }
        }
//        paymentQueue.remove(self)
    }
}

extension SKPaymentTransactionState {
    func status() -> String {
        switch self {
        case .deferred: return "deferred"
        case .failed: return "failed"
        case .purchased: return "purchased"
        case .purchasing: return "purchasing"
        case .restored: return "restored"
        }
    }
}
