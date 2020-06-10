//
//  AppDelegate.swift
//  IAPDemoProject
//
//  Created by Ivan Akulov on 26/10/2017.
//  Copyright © 2017 Ivan Akulov. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        //Инициализация менеджера покупок
        //Проверка на возможность покупок
        IAPManager.shared.setupPurchases { success in
            if success {
                print("Сan make payments")
                //Получение всех ID и продуктов по ним в случае возможности покупки
                IAPManager.shared.getProducts()
            }
        }
        
        return true
    }
}

