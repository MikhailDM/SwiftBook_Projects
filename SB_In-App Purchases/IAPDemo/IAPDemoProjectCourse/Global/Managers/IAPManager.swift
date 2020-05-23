//
//  IAPManager.swift
//  IAPDemoProjectCourse
//
//  Created by Ivan Akulov on 30/10/2017.
//  Copyright © 2017 Ivan Akulov. All rights reserved.
//

import Foundation
import StoreKit
//Менеджер покупок
//Инициализируется при запуске в AppDelegate
//Подписаться под NSObject протокол
class IAPManager: NSObject {
//MARK: - SINGLETONE INIT
    //Должен быть всего 1 менеджер для работы с покупками
    static let shared = IAPManager()
    private override init() {}
    

//MARK: - VARIABLES
    //Идентификатор уведомлений
    static let productNotificationIdentifier = "IAPManagerProductIdentifier"
    
    //Масив продуктов
    var products: [SKProduct] = []
    //Очередь платежей
    let paymentQueue = SKPaymentQueue.default()
 
//MARK: - PURCHASING
    //Проверка возможности покупки
    //callback - Данный блок кода будет выполняться после того как выполниться основной блок
    public func setupPurchases(callback: @escaping(Bool) -> ()) {
        if SKPaymentQueue.canMakePayments() {
            //Добавили себя в качестве наблюдателя
            paymentQueue.add(self)
            callback(true)
            return
        }
        callback(false)
    }
    
    //Получение ID покупок
    public func getProducts() {
        //Множество из ID
        let identifiers: Set = [
            IAPProducts.consumable.rawValue,
            IAPProducts.nonConsumable.rawValue,
            IAPProducts.autoRenewable.rawValue,
            IAPProducts.nonRenewable.rawValue,
        ]
        //Запрос на получение товаров по ID
        let productRequest = SKProductsRequest(productIdentifiers: identifiers)
        //Назначаем себя делегатов
        productRequest.delegate = self
        //Начало запроса
        productRequest.start()
    }
    
    //Метод покупки
    public func purchase(productWith identifier: String) {
        //Проверяем существует ли продукт с таким ID
        guard let product = products.filter({ $0.productIdentifier == identifier }).first else { return }
        //Платеж
        let payment = SKPayment(product: product)
        //Добавление платежа в очередь
        paymentQueue.add(payment)
        
        //Если нужно купить некоторое количество товара
        //let payment1 = SKMutablePayment(product: product)
        //payment1.quantity = 2
    }
    
    //Метод восстановления покупки
    public func restoreCompletedTransactions() {
        paymentQueue.restoreCompletedTransactions()
    }
}




//MARK: - EXTENSION. РАСШИРЕНИЕ НАБЛЮДАТЕЛЯ ЗА ТРАНЗАКЦИЕЙ
extension IAPManager: SKPaymentTransactionObserver {
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        //Транзакции в очереди
        for transaction in transactions {
            switch transaction.transactionState {
            //Транзанкция выполняется бесконечно долго
            case .deferred: break
            //Состояние покупки. Появилось окно покупки
            case .purchasing: break
            //Ошибка транзакции
            case .failed: failed(transaction: transaction)
            //Удачная транзакция
            case .purchased: completed(transaction: transaction)
            //Восстановление покупок
            case .restored: restored(transaction: transaction)
            @unknown default:
                fatalError()
            }
        }
    }
    
    //Метод при ошибке транзакции или отмены при покупке
    private func failed(transaction: SKPaymentTransaction) {
        if let transactionError = transaction.error as NSError? {
            //Проверка на отмену транзакции пользователем
            if transactionError.code != SKError.paymentCancelled.rawValue {
                print("Ошибка транзакции: \(transaction.error!.localizedDescription)")
            }
        }
        //Завершение транзакции
        paymentQueue.finishTransaction(transaction)
    }
    
    //Метод при удачной транзакции
    //Мы отправляем уведомление в Notification Center и там уже начисляем покупку
    private func completed(transaction: SKPaymentTransaction) {
        NotificationCenter.default.post(name: NSNotification.Name(transaction.payment.productIdentifier), object: nil)
        paymentQueue.finishTransaction(transaction)
    }
    
    //Метод восстановления покупок
    //Мы отправляем уведомление в Notification Center и там уже восстанавливаем покупку
    private func restored(transaction: SKPaymentTransaction) {
        paymentQueue.finishTransaction(transaction)
    }
}




//MARK: - EXTENSION. SKProductsRequestDelegate
extension IAPManager: SKProductsRequestDelegate {
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        //Все товары из response
        self.products = response.products
        //Перебор продуктов и печать названий
        products.forEach { print($0.localizedTitle) }
        //Если товары есть - добавляем уведомление в Notification Center
        if products.count > 0 {
            NotificationCenter.default.post(name: NSNotification.Name(IAPManager.productNotificationIdentifier), object: nil)
        }
    }
}




























