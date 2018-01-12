//
//  NotificationDelegate.swift
//  PontoConcrete
//
//  Created by Douglas Medeiros on 03/01/18.
//  Copyright © 2018 Lucas Salton Cardinali. All rights reserved.
//

import UIKit
import Foundation
import UserNotifications

class NotificationDelegate: NSObject, UNUserNotificationCenterDelegate {
    
    var actionCallback: (() -> Void)?
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert,.sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        
        switch response.actionIdentifier {
        case .registerAction:
            self.actionClicked()
        case .cancelAction:
            print("CancelAction")
        default:
            print("Unknown action")
        }
        
        completionHandler()
        
    }
}

extension NotificationDelegate {
    
    @objc
    func actionClicked() {
        actionCallback?()
    }
}
