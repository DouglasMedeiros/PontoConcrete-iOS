//
//  LocationManager.swift
//  MatchPoint
//
//  Created by Douglas Brito de Medeiros on 11/11/17.
//  Copyright © 2017 Lucas Salton Cardinali. All rights reserved.
//

import UIKit
import CoreLocation

class LocationManager: NSObject {
    
    var authorizationStatusCallback: ((_ authorizationStatus: CLAuthorizationStatus) -> Void)?
    var locationCallback: ((_ location: CLLocation?, _ error: Error?) -> Void)?
    
    let locationManager: CLLocationManager
    
    override init() {
        self.locationManager = CLLocationManager()
        
        super.init()
        
        locationManager.delegate = self
        locationManager.distanceFilter = kCLLocationAccuracyNearestTenMeters
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func requestAuthorization() {
        let status = CLLocationManager.authorizationStatus()
        authorizationStatusCallback?(status)
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        
        locationCallback?(location, nil)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error location: \(error.localizedDescription)")
        locationCallback?(nil, error)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        authorizationStatusCallback?(status)
    }
}
