//
//  NotificationPointBH.swift
//  MatchPoint
//
//  Created by Douglas Brito de Medeiros on 11/11/17.
//  Copyright © 2017 Lucas Salton Cardinali. All rights reserved.
//

import CoreLocation
import UserNotifications

class NotificationPointBH: NotificationPoint {
    
    let content: UNMutableNotificationContent
    
    var point: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: -19.935331, longitude: -43.929717)
    }
    
    var name: String {
        return "ConcreteBH"
    }
    
    init(content: UNMutableNotificationContent) {
        self.content = content
    }
    
    func request() -> UNNotificationRequest {
        let region = CLCircularRegion(center: self.point, radius: 100, identifier: self.name)
        region.notifyOnExit = true
        region.notifyOnEntry = true
        
        let trigger = UNLocationNotificationTrigger(region: region, repeats: true)
        
        return UNNotificationRequest(identifier: self.name, content: self.content, trigger: trigger)
    }
}
