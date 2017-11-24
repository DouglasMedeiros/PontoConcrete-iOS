//
//  GeocoderManager.swift
//  MatchPoint
//
//  Created by Douglas Medeiros on 20/11/17.
//  Copyright © 2017 Lucas Salton Cardinali. All rights reserved.
//

import Foundation
import CoreLocation

class GeocoderManager {
    
    lazy var geocoder = CLGeocoder()
    
    func reverse(location: CLLocation, completeHandler: @escaping (PointData?, Error?) -> Void) {
        self.geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
            if let error = error {
                print("Unable to Reverse Geocode Location (\(error))")
                print("Unable to Find Address for Location")
                completeHandler(nil, error)
            } else {
                if let placemarks = placemarks, let placemark = placemarks.first {
                    guard let address = placemark.compactAddress else {
                        return
                    }
                    
                    let pointData = PointData(location: location, address: address)
                    
                    completeHandler(pointData, nil)
                } else {
                    let error = NSError(domain: "", code: 9912, userInfo: nil)
                    completeHandler(nil, error)
                }
            }
        }
    }
}
