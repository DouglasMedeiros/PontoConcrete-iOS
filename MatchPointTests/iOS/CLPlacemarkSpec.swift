//
//  CLPlacemarkSpec.swift
//  MatchPointTests
//
//  Created by Douglas Medeiros on 25/11/17.
//  Copyright © 2017 Lucas Salton Cardinali. All rights reserved.
//

import Quick
import Nimble
import MapKit
import Contacts
import CoreLocation

@testable import MatchPoint

class CLPlacemarkSpec: QuickSpec {
    
    override func spec() {
        
        var sut: CLPlacemark!
        
        it("should be able to create a address formatted") {
            let postal = CNMutablePostalAddress()
            postal.street = "Fagundes Dias, 221"
            postal.city = "São Paulo"
            postal.subLocality = "Saúde"
            postal.country = "Brasil"
            postal.state = "SP"
            sut = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 10, longitude: 20), postalAddress: postal)
            expect(sut.compactAddress).to(equal("Fagundes Dias, 221 - Saúde, São Paulo - SP, Brasil"))
        }
        
    }
}
