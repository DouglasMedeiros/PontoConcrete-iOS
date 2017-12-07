//
//  GoogleGeocodeServiceSpec.swift
//  PontoConcreteTests
//
//  Created by Douglas Medeiros on 28/11/17.
//  Copyright © 2017 Lucas Salton Cardinali. All rights reserved.
//

import Quick
import Nimble
import Moya
import CoreLocation
import Result

@testable import PontoConcrete

class GoogleGeocodeAPIMock: IGoogleGeocodeAPI {
    var geocodeCalled = false
    var passedCoordinate: CLLocationCoordinate2D?
    var passedPassword: String?
    var passedCallbackCompletion: IGoogleGeocodeAPI.GeocodeCompletion?
    
    func geocode(coordinate: CLLocationCoordinate2D, callback: @escaping IGoogleGeocodeAPI.GeocodeCompletion) -> Cancellable {
        geocodeCalled = true
        passedCoordinate = coordinate
        passedCallbackCompletion = callback
        return RequestMock()
    }
}

class GoogleGeocodeServiceSpec: QuickSpec {
    
    override func spec() {
        
        var sut: GoogleGeocodeService!
        
        describe("GoogleGeocodeService") {
            context("when creating") {
                var api: GoogleGeocodeAPIMock!
                
                beforeEach {
                    api = GoogleGeocodeAPIMock()
                    sut = GoogleGeocodeService(provider: api)
                }
                
                it("instance") {
                    expect(sut.api) === api
                }
                
                it("geocode") {
                    let callback: IGoogleGeocodeAPI.GeocodeCompletion = { _,_  in }
                    let location = CLLocation(latitude: 10, longitude: 20)
                    sut.geocode(coordinate: location.coordinate, callback: callback)
                    
                    expect(api.geocodeCalled).to(beTruthy())
                    expect(api.passedCoordinate?.latitude).to(equal(location.coordinate.latitude))
                    expect(api.passedCoordinate?.longitude).to(equal(location.coordinate.longitude))
                    expect(api.passedCallbackCompletion).toNot(beNil())
                }
            }
        }
    }
}


