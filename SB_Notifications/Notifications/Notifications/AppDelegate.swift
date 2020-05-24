//
//  AppDelegate.swift
//  Notifications
//
//  Created by Alexey Efimov on 21.06.2018.
//  Copyright © 2018 Alexey Efimov. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    

    var window: UIWindow?
    let notifications = Notifications()
   

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        //Разрешение на отправку уведомлений
        notifications.requestAutorization()
        //Назначаем делегата
        notifications.notificationCenter.delegate = notifications
        return true
    }
    

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        
        //При каждом запуске обнуляем счетчик уведомлений
        UIApplication.shared.applicationIconBadgeNumber = 0
    }

}
