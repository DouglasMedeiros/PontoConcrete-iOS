//
//  GeocoderManager.swift
//  MatchPoint
//
//  Created by Douglas Medeiros on 20/11/17.
//  Copyright © 2017 Lucas Salton Cardinali. All rights reserved.
//

import Foundation
import CoreLocation

protocol IGeocoderManager {
    func reverse(location: CLLocation, completeHandler: @escaping (PointData?, Error?) -> Void)
}

class GGeocoderManager: IGeocoderManager {
    
    var geocoder: IGoogleGeocodeService = GoogleGeocodeService()
    
    func reverse(location: CLLocation, completeHandler: @escaping (PointData?, Error?) -> Void) {
        self.geocoder.geocode(coordinate: location.coordinate) { (response, result) in
            switch result {
            case .success:
                let point = PointData(location: location, address: response?.address ?? "")
                completeHandler(point, nil)
            case .failure(let error):
                completeHandler(nil, error)
            }
        }
    }
}
