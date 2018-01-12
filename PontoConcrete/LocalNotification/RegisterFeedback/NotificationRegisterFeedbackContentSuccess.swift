//
//  NotificationRegisterFeedbackContentSuccess.swift
//  PontoConcrete
//
//  Created by Douglas Medeiros on 04/01/18.
//  Copyright © 2018 Lucas Salton Cardinali. All rights reserved.
//

import Foundation
import UserNotifications

class NotificationRegisterFeedbackContentSuccess: UNMutableNotificationContent {
    override init() {
        super.init()
        self.title = "PontoConcrete"
        self.body = "Ponto registrado com sucesso!"
        self.categoryIdentifier = "FeedbackSuccessCategory"
        self.sound = UNNotificationSound.default()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
