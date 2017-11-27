//
//  UserNotificationCenter.swift
//  MatchPoint
//
//  Created by Douglas Medeiros on 20/11/17.
//  Copyright © 2017 Lucas Salton Cardinali. All rights reserved.
//

import Foundation
import UserNotifications

class UserNotificationCenter {
    let center: UNUserNotificationCenter
    let options: UNAuthorizationOptions
    
    init(center: UNUserNotificationCenter = UNUserNotificationCenter.current(),
         options: UNAuthorizationOptions = [.alert, .sound]) {
        self.center = center
        self.options = options
    }
    
    func requestNotifications() {
        center.requestAuthorization(options: options) { (granted, error) in
            if !granted {
                print("Something went wrong: \(error?.localizedDescription ?? "error")")
            } else {
                self.setupNotifications()
            }
        }
    }
    
    private func setupNotifications() {
        self.removeAll()
        
        center.add(NotificationPointFactory.notification(for: .saoPaulo).request())
        center.add(NotificationPointFactory.notification(for: .rioDeJaneiro).request())
        center.add(NotificationPointFactory.notification(for: .minasGerais).request())
    }
    
    func removeAll() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
}
