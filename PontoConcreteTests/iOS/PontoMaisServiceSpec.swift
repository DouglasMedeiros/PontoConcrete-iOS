//
//  PontoMaisServiceSpec.swift
//  PontoConcreteTests
//
//  Created by Douglas Medeiros on 25/11/17.
//  Copyright © 2017 Lucas Salton Cardinali. All rights reserved.
//

import Quick
import Nimble
import Moya
import CoreLocation
import Result

@testable import PontoConcrete

class RequestMock: Cancellable {
    var isCancelled = false
    func cancel() {
        isCancelled = true
    }
}

class PontoMaisAPIMock: IPontoMaisAPI {
    var loginCalled = false
    var passedEmail: String?
    var passedPassword: String?
    var passedCallbackLoginCompletion: IPontoMaisAPI.LoginCompletion?
    func login(email: String, password: String, callback: @escaping IPontoMaisAPI.LoginCompletion) -> Cancellable {
        loginCalled = true
        passedPassword = password
        passedEmail = email
        passedCallbackLoginCompletion = callback
        return RequestMock()
    }
    
    var registerCalled = false
    var passedCredentials: SessionData?
    var passedPoint: PointData?
    var passedCallbackRegisterCompletion: IPontoMaisAPI.RegisterCompletion?
    
    func register(credentials: SessionData, point: PointData, callback: @escaping IPontoMaisAPI.RegisterCompletion) -> Cancellable {
        
        registerCalled = true
        passedCallbackRegisterCompletion = callback
        passedCredentials = credentials
        passedPoint = point
        return RequestMock()
    }
}

class PontoMaisServiceSpec: QuickSpec {
    
    override func spec() {
        
        var sut: PontoMaisService!
        
        describe("PontoMaisService") {
            
            context("when creating") {
                
                var api: PontoMaisAPIMock!
                
                beforeEach {
                    api = PontoMaisAPIMock()
                    sut = PontoMaisService(provider: api)
                }
                
                it("instance") {
                    expect(sut.api) === api
                }
                
                it("login") {
                    
                    let callback: IPontoMaisAPI.LoginCompletion = { _,_  in }
                    sut.login(email: "email@server.com", password: "abc123", callback: callback)

                    expect(api.loginCalled).to(beTruthy())
                    expect(api.passedEmail).to(equal("email@server.com"))
                    expect(api.passedPassword).to(equal("abc123"))
                    expect(api.passedCallbackLoginCompletion).toNot(beNil())
                }
                
                it("register") {
                    let credential = SessionData(token: "abc123", clientId: "cde123", email: "email@server.com")
                    let location = CLLocation(latitude: 10, longitude: 20)
                    let address = "Street, 123 - CA"
                    let point = PointData(location: location, address: address)
                    
                    let callback: IPontoMaisAPI.RegisterCompletion = { _,_  in }
                    sut.register(credentials: credential, point: point, callback: callback)
                    
                    expect(api.registerCalled).to(beTruthy())
                    expect(api.passedCredentials?.token).to(equal("abc123"))
                    expect(api.passedCredentials?.clientId).to(equal("cde123"))
                    expect(api.passedPoint?.address).to(equal("Street, 123 - CA"))
                    expect(api.passedPoint?.location.coordinate.latitude).to(equal(10))
                    expect(api.passedPoint?.location.coordinate.longitude).to(equal(20))
                    expect(api.passedCallbackRegisterCompletion).toNot(beNil())
                }
            }
        }
    }
}

