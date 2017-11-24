//
//  NotificationPointRJ.swift
//  MatchPoint
//
//  Created by Douglas Brito de Medeiros on 11/11/17.
//  Copyright © 2017 Lucas Salton Cardinali. All rights reserved.
//

import CoreLocation
import UserNotifications

class NotificationPointRJ: NotificationPoint {
    
    let content: UNMutableNotificationContent
    
    var point: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: -22.910222, longitude: -43.172658)
    }
    
    var name: String {
        return "ConcreteRJ"
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
