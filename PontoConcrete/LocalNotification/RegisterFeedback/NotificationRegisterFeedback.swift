//
//  NotificationRegisterFeedback.swift
//  PontoConcrete
//
//  Created by Douglas Medeiros on 04/01/18.
//  Copyright © 2018 Lucas Salton Cardinali. All rights reserved.
//

import UserNotifications

protocol NotificationRegisterFeedback {
    func request() -> UNNotificationRequest
}
