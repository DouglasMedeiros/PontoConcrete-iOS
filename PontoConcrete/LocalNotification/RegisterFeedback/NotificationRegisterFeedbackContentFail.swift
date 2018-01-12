//
//  NotificationRegisterFeedbackContentFail.swift
//  PontoConcrete
//
//  Created by Douglas Medeiros on 04/01/18.
//  Copyright © 2018 Lucas Salton Cardinali. All rights reserved.
//

import Foundation
import UserNotifications

class NotificationRegisterFeedbackContentFail: UNMutableNotificationContent {
    override init() {
        super.init()
        self.title = "PontoConcrete"
        self.body = "Ops! Houve um problema ao tentar registrar o ponto!\nTente novamente."
        self.categoryIdentifier = "FeedbackFailCategory"
        self.sound = UNNotificationSound.default()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
