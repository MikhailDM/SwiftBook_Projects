//
//  IAPManager.swift
//  IAPDemoProjectCourse
//
//  Created by Ivan Akulov on 30/10/2017.
//  Copyright © 2017 Ivan Akulov. All rights reserved.
//

import Foundation
import StoreKit

class IAPManager: NSObject {
    
    static let productNotificationIdentifier = "IAPManagerProductIdentifier"
    static let shared = IAPManager()
    private override init() {}
    
    var products: [SKProduct] = []
    let paymentQueue = SKPaymentQueue.default()
    
    public func setupPurchases(callback: @escaping(Bool) -> ()) {
        if SKPaymentQueue.canMakePayments() {
            paymentQueue.add(self)
            callback(true)
            return
        }
        callback(false)
    }
    
    public func getProducts() {
        let identifiers: Set = [
            IAPProducts.consumable.rawValue,
            IAPProducts.nonConsumable.rawValue,
            IAPProducts.autoRenewable.rawValue,
            IAPProducts.nonRenewable.rawValue,
        ]
        
        let productRequest = SKProductsRequest(productIdentifiers: identifiers)
        productRequest.delegate = self
        productRequest.start()
    }
    
    public func purchase(productWith identifier: String) {
        guard let product = products.filter({ $0.productIdentifier == identifier }).first else { return }
        let payment = SKPayment(product: product)
        paymentQueue.add(payment)
    }
    
    public func restoreCompletedTransactions() {
        paymentQueue.restoreCompletedTransactions()
    }
}


extension IAPManager: SKPaymentTransactionObserver {
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            switch transaction.transactionState {
            case .deferred: break
            case .purchasing: break
            case .failed: failed(transaction: transaction)
            case .purchased: completed(transaction: transaction)
            case .restored: restored(transaction: transaction)
            }
        }
    }
    
    private func failed(transaction: SKPaymentTransaction) {
        if let transactionError = transaction.error as NSError? {
            if transactionError.code != SKError.paymentCancelled.rawValue {
                print("Ошибка транзакции: \(transaction.error!.localizedDescription)")
            }
        }
        paymentQueue.finishTransaction(transaction)
    }
    
    private func completed(transaction: SKPaymentTransaction) {
        let receiptValidator = ReceiptValidator()
        let result = receiptValidator.validateReceipt()
        
        switch result {
        case let .success(receipt):
            guard let purchase = receipt.inAppPurchaseReceipts?.filter({ $0.productIdentifier == IAPProducts.autoRenewable.rawValue }).first else {
                NotificationCenter.default.post(name: NSNotification.Name(transaction.payment.productIdentifier), object: nil)
                paymentQueue.finishTransaction(transaction)
                return
            }
            
            if purchase.subscriptionExpirationDate?.compare(Date()) == .orderedDescending {
                UserDefaults.standard.set(true, forKey: IAPProducts.autoRenewable.rawValue)
            } else {
                UserDefaults.standard.set(false, forKey: IAPProducts.autoRenewable.rawValue)
                print("Subscription has ended")
            }
            
               NotificationCenter.default.post(name: NSNotification.Name(transaction.payment.productIdentifier), object: nil)
            
        case let .error(error):
            print(error.localizedDescription)
        }
        
        paymentQueue.finishTransaction(transaction)
    }
    
    private func restored(transaction: SKPaymentTransaction) {
        paymentQueue.finishTransaction(transaction)
    }
}

extension IAPManager: SKProductsRequestDelegate {
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        self.products = response.products
        products.forEach { print($0.localizedTitle) }
        if products.count > 0 {
            NotificationCenter.default.post(name: NSNotification.Name(IAPManager.productNotificationIdentifier), object: nil)
        }
    }
}




























