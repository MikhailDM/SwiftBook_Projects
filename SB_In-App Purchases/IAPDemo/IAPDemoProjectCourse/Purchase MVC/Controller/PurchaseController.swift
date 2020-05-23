//
//  PurchaseController.swift
//  IAPDemoProject
//
//  Created by Ivan Akulov on 26/10/2017.
//  Copyright © 2017 Ivan Akulov. All rights reserved.
//

import UIKit
import StoreKit

class PurchaseController: UIViewController {
//MARK: - OUTLETS
    @IBOutlet weak var tableView: UITableView!
    
    
//MARK: - OBJECTS
    let iapManager = IAPManager.shared
    let notificationCenter = NotificationCenter.default
 
    
//MARK: - LOADING
    override func viewDidLoad() {
        super.viewDidLoad()
        //Отображение UITableView bottom
        tableView.tableFooterView = UIView()
        setupNavigationBar()
        
        //Наблюдатели за уведомлениями Notification Center
        notificationCenter.addObserver(self, selector: #selector(reload), name: NSNotification.Name(IAPManager.productNotificationIdentifier), object: nil)
        //Уведомление об определенной покупке и вызов метода
        notificationCenter.addObserver(self, selector: #selector(completeConsumable), name: NSNotification.Name(IAPProducts.consumable.rawValue), object: nil)
        //Уведомление об определенной покупке и вызов метода
        notificationCenter.addObserver(self, selector: #selector(completeNonConsumable), name: NSNotification.Name(IAPProducts.nonConsumable.rawValue), object: nil)
        //Уведомление об определенной покупке и вызов метода
        notificationCenter.addObserver(self, selector: #selector(completeAutoRenewable), name: NSNotification.Name(IAPProducts.autoRenewable.rawValue), object: nil)
        //Уведомление об определенной покупке и вызов метода
        notificationCenter.addObserver(self, selector: #selector(completeNonRenewable), name: NSNotification.Name(IAPProducts.nonRenewable.rawValue), object: nil)
    }
    //Удаление из наблюдателя при закрытии View
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    
//MARK: - FUNCTIONS
    //Настройки бара навигации
    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Restore", style: .plain, target: self, action: #selector(restorePurchases))
    }
    
    //Восстановление покупок
    @objc private func restorePurchases() {
        iapManager.restoreCompletedTransactions()
    }
    
    //Метод локализации цен
    private func priceStringFor(product: SKProduct) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.locale = product.priceLocale
        return numberFormatter.string(from: product.price)!
    }
    
    //Обновление UITableView при получении уведомления
    @objc private func reload() {
        self.tableView.reloadData()
    }
    
    //Метод при удачной покупке
    @objc private func completeConsumable() {
        print("got consumable")
    }
    //Метод при удачной покупке
    @objc private func completeNonConsumable() {
        print("got non-consumable")
    }
    //Метод при удачной покупке
    @objc private func completeAutoRenewable() {
        print("got auto-renewable")
    }
    //Метод при удачной покупке
    @objc private func completeNonRenewable() {
        print("got non-renewable")
    }
}




//MARK: - EXTENSION. UITableViewDataSource
extension PurchaseController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //Количество товаров
        return iapManager.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.purchaseCell, for: indexPath)
        //Продукт ячейки
        let product = iapManager.products[indexPath.row]
        //Название продукта с локализованной ценой
        cell.textLabel?.text = product.localizedTitle + " - " + self.priceStringFor(product: product)
        return cell
    }
}




//MARK: - EXTENSION. UITableViewDelegate
extension PurchaseController: UITableViewDelegate {
    //Нажатие на строку
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //ID покупки
        let identifier = iapManager.products[indexPath.row].productIdentifier
        //Метод покупки
        iapManager.purchase(productWith: identifier)
        //Отжатие ячейки
        tableView.deselectRow(at: indexPath, animated: true)
    }
}








