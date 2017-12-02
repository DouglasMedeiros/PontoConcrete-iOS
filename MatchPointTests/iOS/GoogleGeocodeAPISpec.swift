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
import CoreLocation

@testable import MatchPoint

class GoogleGeocodeAPISpec: QuickSpec {
    override func spec() {
        
        var sut: GoogleGeocodeAPI!
        
        beforeEach {
            let endpointClosure = { (target: GoogleGeocodeRoute) -> Endpoint<GoogleGeocodeRoute> in
                return Endpoint<GoogleGeocodeRoute>(url: URL(target: target).absoluteString,
                                                sampleResponseClosure: {
                                                    return .networkResponse(200, target.sampleData)
                }, method: target.method, task: target.task, httpHeaderFields: target.headers)
            }
            
            let provider = MoyaProvider<GoogleGeocodeRoute>(endpointClosure: endpointClosure, stubClosure: MoyaProvider.immediatelyStub)
            sut = GoogleGeocodeAPI(provider: provider)
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
                    beforeEach {
                        let endpointClosure = { (target: GoogleGeocodeRoute) -> Endpoint<GoogleGeocodeRoute> in
                            return Endpoint<GoogleGeocodeRoute>(url: URL(target: target).absoluteString,
                                                            sampleResponseClosure: {
                                                                return .networkError(NSError())
                            }, method: target.method, task: target.task, httpHeaderFields: target.headers)
                        }
                        
                        let provider = MoyaProvider<GoogleGeocodeRoute>(endpointClosure: endpointClosure, stubClosure: MoyaProvider.immediatelyStub)
                        sut = GoogleGeocodeAPI(provider: provider)
                    }
                    
                    it("location") {
                        let location = CLLocation(latitude: 10, longitude: 20)
                        
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

