//
//  NotificationController.swift
//  MatchPoint WatchOS Extension
//
//  Created by Douglas Medeiros on 19/11/17.
//  Copyright © 2017 Lucas Salton Cardinali. All rights reserved.
//

import WatchKit
import Foundation
import UserNotifications

class NotificationController: WKUserNotificationInterfaceController {

    @IBOutlet weak private(set) var notificationAlertLabel: WKInterfaceLabel?
    
    override init() {
        super.init()
    }
    
    override func willActivate() {
        super.willActivate()
    }

    override func didDeactivate() {
        super.didDeactivate()
    }

    override func didReceive(_ notification: UNNotification, withCompletion completionHandler: @escaping (WKUserNotificationInterfaceType) -> Swift.Void) {
        self.notificationAlertLabel?.setText(notification.request.content.body)
        completionHandler(.custom)
    }
    
}
