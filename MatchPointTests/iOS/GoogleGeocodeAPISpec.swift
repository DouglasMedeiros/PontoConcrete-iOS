//
//  GoogleGeocodeAPISpec.swift
//  MatchPointTests
//
//  Created by Douglas Medeiros on 28/11/17.
//  Copyright © 2017 Lucas Salton Cardinali. All rights reserved.
//

import Moya
import Quick
import Nimble
import OHHTTPStubs
import CoreLocation

@testable import MatchPoint

class GoogleGeocodeAPISpec: QuickSpec {
    override func spec() {
        
        var sut: GoogleGeocodeAPI!
        
        beforeEach {
            let provider = MoyaProvider<GoogleGeocodeRoute>()
            sut = GoogleGeocodeAPI(provider: provider)
        }
        
        afterEach {
            OHHTTPStubs.removeAllStubs()
        }
        
        it("should be able to create a instance of PontoMaisAPI") {
            expect(sut).toNot(beNil())
        }
        
        describe("Requests") {
            context("register") {
                context("successfull") {
                    it("location sucess") {
                        let location = CLLocation(latitude: 10, longitude: 20)
                        
                        let data = GoogleGeocodeRoute.geocode(coordinate: location.coordinate).sampleData
                        OHHTTPStubs.stubRequests(passingTest: { $0.url!.path == "/maps/api/geocode/json" }, withStubResponse: { _ in
                            return OHHTTPStubsResponse(data: data, statusCode: 200, headers: nil)
                        })
                        
                        let expectResult = String(data: data, encoding: .utf8)
                        var message: String?
                        
                        waitUntil { done in
                            sut.geocode(coordinate: location.coordinate, callback: { (response, result) in
                                if case .success(let response) = result {
                                    message = String(data: response.data, encoding: .utf8)
                                    done()
                                }
                            })
                        }
                        expect(message).to(equal(expectResult))
                    }
                }
                context("error") {
                    it("location") {
                        let location = CLLocation(latitude: 10, longitude: 20)
                        let json = "{\"error_message\":\"Invalid request. Invalid 'latlng' parameter.\",\"results\":[],\"status\":\"INVALID_REQUEST\"}"
                        
                        guard let data = json.data(using: .utf8) else {
                            fatalError("Error sample data JSON")
                        }
                        
                        OHHTTPStubs.stubRequests(passingTest: { $0.url!.path == "/api/time_cards/register" }, withStubResponse: { _ in
                            return OHHTTPStubsResponse(data: data, statusCode: 200, headers: nil)
                        })
                        
                        var message: String?
                        
                        waitUntil { done in
                            let request = sut.geocode(coordinate: location.coordinate, callback: { (response, result) in
                                if case .failure = result {
                                    message = ""
                                    done()
                                    return
                                }
                                fail()
                            })
                            request.cancel()
                        }
                        expect(message).to(beEmpty())
                    }
                }
            }
        }
    }
}

