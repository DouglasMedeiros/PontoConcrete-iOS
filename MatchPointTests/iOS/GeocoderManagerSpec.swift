//
//  GeocoderManagerSpec.swift
//  MatchPointTests
//
//  Created by Douglas Medeiros on 26/11/17.
//  Copyright © 2017 Lucas Salton Cardinali. All rights reserved.
//

import Quick
import Nimble
import CoreLocation
import Contacts
import MapKit
import Moya

@testable import MatchPoint

class GeocoderMock: IGoogleGeocodeService {
    var passedReverse: Bool = false
    var passedLocation: CLLocationCoordinate2D?
    var passedHandler: IGoogleGeocodeAPI.GeocodeCompletion?

    func geocode(coordinate: CLLocationCoordinate2D, callback: @escaping IGoogleGeocodeAPI.GeocodeCompletion) -> Cancellable {
        passedReverse = true
        passedLocation = coordinate
        passedHandler = callback
        return RequestMock()
    }
}

class GeocoderManagerSpec: QuickSpec {
    
    override func spec() {
        var sut: GGeocoderManager!
        var geocoder: GeocoderMock!
        
        describe("GeocoderManager") {
            context("when creating") {
                
                beforeEach {
                    sut = GGeocoderManager()
                    geocoder = GeocoderMock()
                    sut.geocoder = geocoder
                }
                
                it("instance") {
                    let location = CLLocation(latitude: 10, longitude: 20)
                    sut.reverse(location: location, completeHandler: { (point, error) in })
                    expect(geocoder.passedReverse).to(beTrue())
                }
                
            }
        }
    }
}


