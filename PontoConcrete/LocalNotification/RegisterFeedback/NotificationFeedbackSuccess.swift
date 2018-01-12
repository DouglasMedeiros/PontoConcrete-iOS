//
//  NotificationFeedbackSuccess.swift
//  PontoConcrete
//
//  Created by Douglas Medeiros on 04/01/18.
//  Copyright © 2018 Lucas Salton Cardinali. All rights reserved.
//

import Foundation
import UserNotifications

class NotificationFeedbackSuccess: NotificationRegisterFeedback {
    
    let content: UNMutableNotificationContent
    
    init(content: UNMutableNotificationContent) {
        self.content = content
    }
    
    func request() -> UNNotificationRequest {
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        
        return UNNotificationRequest(identifier: "success", content: self.content, trigger: trigger)
    }
}
