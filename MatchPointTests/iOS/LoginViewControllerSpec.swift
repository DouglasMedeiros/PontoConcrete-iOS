//
//  LoginViewControllerSpec.swift
//  MatchPointTests
//
//  Created by Douglas Medeiros on 26/11/17.
//  Copyright © 2017 Lucas Salton Cardinali. All rights reserved.
//

import Quick
import Nimble
import Nimble_Snapshots
import OHHTTPStubs
import CoreLocation

@testable import MatchPoint

class LoginViewControllerSpec: QuickSpec {
    
    override func spec() {
        var sut: LoginViewController!
        
        describe("LoginViewController") {
            context("when creating") {
                
                beforeEach {
                    sut = LoginViewController()
                    _ = sut.view
                }
                
                it("instance") {
                    expect(sut.view.isKind(of: LoginView.self)).to(beTrue())
                }
                
                it("press login") {
                    let email = "email@server.com"
                    let password = "123456"
                    
                    let data = PontoMaisRoute.login(login: email, password: password).sampleData
                    OHHTTPStubs.stubRequests(passingTest: { $0.url!.path == "/api/auth/sign_in" }, withStubResponse: { _ in
                        return OHHTTPStubsResponse(data: data, statusCode: 200, headers: nil)
                    })
                    
                    sut.containerView.emailTextField.text = email
                    sut.containerView.passwordTextField.text = password
                    
                    sut.containerView.loginButton.sendActions(for: .touchUpInside)
                    sut.containerView.frame = CGRect(x: 0, y: 0, width: 375, height: 667)
                    
                    expect(sut.containerView.activityIndicator.isAnimating).to(beTrue())
                }
                
            }
        }
    }
}

