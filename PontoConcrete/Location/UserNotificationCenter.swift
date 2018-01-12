//
//  UserNotificationCenter.swift
//  PontoConcrete
//
//  Created by Douglas Medeiros on 20/11/17.
//  Copyright © 2017 Lucas Salton Cardinali. All rights reserved.
//

//
//  UserNotificationCenter.swift
//  PontoConcrete
//
//  Created by Douglas Medeiros on 20/11/17.
//  Copyright © 2017 Lucas Salton Cardinali. All rights reserved.
//

import Foundation
import UserNotifications

protocol NotificationsSetup {
    func buildNotifications() -> [UNNotificationRequest]
    func buildActions() -> UNNotificationCategory?
}

class NotificationsPointSetup: NotificationsSetup {
    
    func buildNotifications() -> [UNNotificationRequest] {
        return [NotificationPointFactory.notification(for: .saoPaulo).request(),
                NotificationPointFactory.notification(for: .rioDeJaneiro).request(),
                NotificationPointFactory.notification(for: .minasGerais).request()]
    }
    
    func buildActions() -> UNNotificationCategory? {
        let registerAction = UNNotificationAction(identifier: .registerAction, title: "Bater o ponto", options: [])
        let cancelAction = UNNotificationAction(identifier: .cancelAction, title: "Cancelar", options: [.destructive])
        
        let category = UNNotificationCategory(identifier: .reminderCategory, actions: [registerAction, cancelAction], intentIdentifiers: [], options: [])
        
        return category
    }
}

class UserNotificationCenter {
<<<<<<< Updated upstream
=======
    var authorizationStatusCallback: ((_ granted: Bool) -> Void)?
    
    let notifications: NotificationsSetup
>>>>>>> Stashed changes
    let center: UNUserNotificationCenter
    let options: UNAuthorizationOptions
    
    init(center: UNUserNotificationCenter = UNUserNotificationCenter.current(),
         options: UNAuthorizationOptions = [.alert, .sound], notifications: NotificationsSetup) {
        self.center = center
        self.options = options
        self.notifications = notifications
    }
    
    func requestNotifications() {
        center.requestAuthorization(options: options) { (granted, error) in
            if !granted {
                print("Something went wrong: \(error?.localizedDescription ?? "error")")
            } else {
                self.setupNotifications()
            }
<<<<<<< Updated upstream
=======
            
            self.removeAll()
            
            let notifications = self.notifications.buildNotifications()
            notifications.forEach({ notificationRequest in
                self.center.add(notificationRequest)
            })
            
            guard let actions = self.notifications.buildActions() else {
                return
            }
            self.center.setNotificationCategories([actions])
>>>>>>> Stashed changes
        }
    }
    
    func removeAll() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
}

