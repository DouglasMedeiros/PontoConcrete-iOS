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

@testable import MatchPoint

class GeocoderMock: CLGeocoder {
    var passedReverse: Bool = false
    var passedLocation: CLLocation?
    var passedHandler: CLGeocodeCompletionHandler?

    override func reverseGeocodeLocation(_ location: CLLocation, completionHandler: @escaping CLGeocodeCompletionHandler) {
        passedReverse = true
        passedLocation = location
        passedHandler = completionHandler
        
        let postal = CNMutablePostalAddress()
        postal.street = "Fagundes Dias, 221"
        postal.city = "São Paulo"
        postal.subLocality = "Saúde"
        postal.country = "Brasil"
        postal.state = "SP"
        let placemark = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 10, longitude: 20), postalAddress: postal)
        
        completionHandler([placemark], nil)
    }
}

class GeocoderManagerSpec: QuickSpec {
    
    override func spec() {
        var sut: GeocoderManager!
        
        describe("GeocoderManager") {
            context("when creating") {
                
                beforeEach {
                    sut = GeocoderManager()
                    sut.geocoder = GeocoderMock()
                }
                
                it("instance") {
                    let location = CLLocation(latitude: 10, longitude: 20)
                    sut.reverse(location: location, completeHandler: { (point, error) in })
                    expect(sut.lastPoint).toNot(beNil())
                }
                
            }
        }
    }
}


