//
//  Notifications.swift
//  Notifications
//
//  Created by Михаил Дмитриев on 24.05.2020.
//  Copyright © 2020 Alexey Efimov. All rights reserved.
//

import Foundation
import UserNotifications

class Notifications: NSObject, UNUserNotificationCenterDelegate {
//MARK: - OBJECTS
    //Обьект уведомлений
    let notificationCenter = UNUserNotificationCenter.current()
    
    
//MARK: - FUNCTIONS
    //Разрешение на отправку уведомлений
    func requestAutorization() {
        notificationCenter.requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
            print("Permission granted: \(granted)")
            guard granted else { return }
            self.getNotificationSettings()
        }
    }
    //Отслеживание настроек
    //Возвращает параметры которые определил пользователь
    func getNotificationSettings() {
        notificationCenter.getNotificationSettings { (settings) in
            print("Notification settings: \(settings)")
            
            //PUSH
            guard settings.authorizationStatus == .authorized else { return }
            DispatchQueue.main.async {
                //UIApplication.shared.registerForRemoteNotifications()
            }
        }
    }
    
    
    //Запрос на уведомление с определенной датой
    func scheduleNotification(notificationType: String) {
        let content = UNMutableNotificationContent()
        //ID кнопок действия
        let userAction = "User Action"
        
        //Контент
        content.title = notificationType
        content.body = "This is example how to create" + notificationType
        content.sound = UNNotificationSound.default
        content.badge = 1
        content.categoryIdentifier = userAction
        //Картинка
        guard let path = Bundle.main.path(forResource: "favicon", ofType: "png") else { return }
        let url = URL(fileURLWithPath: path)
        do {
            let attachment = try UNNotificationAttachment(identifier: "favicon",
                                                          url: url,
                                                          options: nil)
            content.attachments = [attachment]
        } catch {
            print("The attachment could not be loaded")
        }
        
        //Триггер срабатывания уведомления
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        //ID
        let identifire = "Local Notification"
        let request = UNNotificationRequest(identifier: identifire, content: content, trigger: trigger)
        
        //Центр уведомлений
        notificationCenter.add(request) { error in
            if let error = error {
                print("Error \(error.localizedDescription)")
            }
        }
        //Действие отложить
        let snoozeAction = UNNotificationAction(identifier: "Snooze", title: "Snooze", options: [])
        //Действие удалить
        let deleteAction = UNNotificationAction(identifier: "Delete", title: "Delete", options: [.destructive])
        //Категории
        let category = UNNotificationCategory(identifier: userAction,
                                              actions: [snoozeAction, deleteAction],
                                              intentIdentifiers: [],
                                              options: [])
        //Регистрация
        notificationCenter.setNotificationCategories([category])
    }
    
    
//MARK: - DELEGATE
    //Показ уведомлений если приложение запущено
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound])
    }
    //Тап по уведомлению
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        if response.notification.request.identifier == "Local Notification" {
            print("Handling notification with Local Notification ID")
        }
        
        //Действия кнопок уведомления
        switch response.actionIdentifier {
        case UNNotificationDismissActionIdentifier:
            print("DISMIS")
        case UNNotificationDefaultActionIdentifier:
            print("DEFAULT")
        case "Snooze":
            print("Snooze")
            scheduleNotification(notificationType: "Reminder")
        case "Delete":
            print("Delete")
        default:
            print("Unknown")
        }
        completionHandler()
    }
}
