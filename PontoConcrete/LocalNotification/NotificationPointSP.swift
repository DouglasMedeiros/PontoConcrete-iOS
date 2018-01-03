//
//  NotificationPointSP.swift
//  PontoConcrete
//
//  Created by Douglas Brito de Medeiros on 11/11/17.
//  Copyright © 2017 Lucas Salton Cardinali. All rights reserved.
//

import CoreLocation
import UserNotifications

class NotificationPointSP: NotificationPoint {
    
    let content: UNMutableNotificationContent
    
    var point: Point {
        return .saoPaulo
    }
    
    var name: String {
        return "ConcreteSP"
    }
    
    init(content: UNMutableNotificationContent) {
        self.content = content
    }
    
    func request() -> UNNotificationRequest {
        let region = CLCircularRegion(center: self.point.point().location.coordinate, radius: 100, identifier: self.name)
        region.notifyOnExit = true
        region.notifyOnEntry = true
        
        let trigger = UNLocationNotificationTrigger(region: region, repeats: true)
        
        return UNNotificationRequest(identifier: self.name, content: self.content, trigger: trigger)
    }
}
