//
//  PontoMaisAPISpec.swift
//  MatchPointTests
//
//  Created by Douglas Medeiros on 24/11/17.
//  Copyright © 2017 Lucas Salton Cardinali. All rights reserved.
//

import Moya
import Quick
import Nimble
import OHHTTPStubs
import CoreLocation

@testable import MatchPoint

class PontoMaisAPISpec: QuickSpec {
    override func spec() {

        var sut: PontoMaisAPI!
        
        beforeEach {
            let provider = MoyaProvider<PontoMaisRoute>()
            sut = PontoMaisAPI(provider: provider)
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
                    it("register sucess") {
                        let credential = SessionData(token: "abc", clientId: "abc123", email: "email@server.com")
                        let location = CLLocation(latitude: 10, longitude: 20)
                        let address = "Street 1"
                        let point = PointData(location: location, address: address)
                        let data = PontoMaisRoute.register(data: credential, point: point).sampleData
                        OHHTTPStubs.stubRequests(passingTest: { $0.url!.path == "/api/time_cards/register" }, withStubResponse: { _ in
                            return OHHTTPStubsResponse(data: data, statusCode: 200, headers: nil)
                        })
                        
                        let expectResult = String(data: data, encoding: .utf8)
                        var message: String?
                        
                        waitUntil { done in
                            sut.register(credentials: credential, point: point, callback: { (response, result) in
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
                    it("register") {
                        let credential = SessionData(token: "abc", clientId: "abc123", email: "email@server.com")
                        let location = CLLocation(latitude: 10, longitude: 20)
                        let address = "Street 1"
                        let point = PointData(location: location, address: address)
                        
                        OHHTTPStubs.stubRequests(passingTest: { $0.url!.path == "/api/time_cards/register" }, withStubResponse: { _ in
                            return OHHTTPStubsResponse(data: Data(), statusCode: 401, headers: nil)
                        })
                        
                        var message: String?
                        
                        waitUntil { done in
                            let request = sut.register(credentials: credential, point: point, callback: { (response, result) in
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
            
            context("login") {
                context("successfull") {
                    it("login sucess") {
                        let email = "email@server.com"
                        let password = "123456"

                        let data = PontoMaisRoute.login(login: email, password: password).sampleData
                        OHHTTPStubs.stubRequests(passingTest: { $0.url!.path == "/api/auth/sign_in" }, withStubResponse: { _ in
                            return OHHTTPStubsResponse(data: data, statusCode: 200, headers: nil)
                        })

                        let expectResult = String(data: data, encoding: .utf8)
                        var message: String?

                        waitUntil { done in
                            sut.login(email: email, password: password, callback: { (response, result) in
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
                    it("login error") {
                        
                        let email = "email@server.com"
                        let password = "123456"
                        
                        let json = "{\"error\":\"Usuário e/ou senha inválidos\",\"meta\":{\"now\":1511032961,\"ip\":\"179.35.195.159\"}}"
                        
                        guard let data = json.data(using: .utf8) else {
                            fatalError("Error sample data JSON")
                        }
                        
                        OHHTTPStubs.stubRequests(passingTest: { $0.url!.path == "/api/auth/sign_in" }, withStubResponse: { _ in
                            return OHHTTPStubsResponse(data: data, statusCode: 200, headers: nil)
                        })
                        
                        let expectResult = String(data: data, encoding: .utf8)
                        var message: String?
                        
                        waitUntil { done in
                            sut.login(email: email, password: password, callback: { (response, result) in
                                if case .success(let response) = result {
                                    message = String(data: response.data, encoding: .utf8)
                                    done()
                                    return
                                }
                                
                                fail()
                            })
                        }
                        
                        expect(message).to(equal(expectResult))
                    }
                    
                    it("login error request") {

                        let email = "email@server.com"
                        let password = "123456"

                        OHHTTPStubs.stubRequests(passingTest: { $0.url!.path == "/api/auth/sign_in" }, withStubResponse: { _ in
                            return OHHTTPStubsResponse(data: Data(), statusCode: 401, headers: nil)
                        })

                        var message: String?

                        waitUntil { done in
                            let request = sut.login(email: email, password: password, callback: { (response, result) in
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
