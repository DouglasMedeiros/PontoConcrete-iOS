//
//  NotificationPoint.swift
//  MatchPoint
//
//  Created by Douglas Brito de Medeiros on 11/11/17.
//  Copyright © 2017 Lucas Salton Cardinali. All rights reserved.
//

import CoreLocation
import UserNotifications

protocol NotificationPoint {
    var point: CLLocationCoordinate2D { get }
    var name: String { get }
    func request() -> UNNotificationRequest
}
