//
//  GoogleGeocodeService.swift
//  MatchPoint
//
//  Created by Douglas Medeiros on 27/11/17.
//  Copyright © 2017 Lucas Salton Cardinali. All rights reserved.
//

import Foundation
import Moya
import CoreLocation

protocol IGoogleGeocodeService: class {
    func geocode(coordinate: CLLocationCoordinate2D, callback: @escaping IGoogleGeocodeAPI.GeocodeCompletion) -> Cancellable
}

class GoogleGeocodeService {
    let api: IGoogleGeocodeAPI
    
    init(provider: IGoogleGeocodeAPI = GoogleGeocodeAPI()) {
        api = provider
    }
}

extension GoogleGeocodeService: IGoogleGeocodeService {
    @discardableResult
    func geocode(coordinate: CLLocationCoordinate2D, callback: @escaping IGoogleGeocodeAPI.GeocodeCompletion) -> Cancellable {
        return self.api.geocode(coordinate: coordinate, callback: callback)
    }
}
