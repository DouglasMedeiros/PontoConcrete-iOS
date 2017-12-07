//
//  LoginViewSpec.swift
//  PontoConcreteTests
//
//  Created by Douglas Medeiros on 25/11/17.
//  Copyright © 2017 Lucas Salton Cardinali. All rights reserved.
//

import Quick
import Nimble
import Nimble_Snapshots

@testable import PontoConcrete

class LoginViewSpec: QuickSpec {
    override func spec() {
        
        var sut: LoginView!
        
        beforeEach {
            sut = LoginView()
        }
        
        it("should be able to create a instance of LoginView") {
            expect(sut).toNot(beNil())
        }
        
        context("layout", {
            it("should have expected layout ready state") {
                sut.frame = CGRect(x: 0, y: 0, width: 375, height: 667)
                expect(sut) == snapshot("LoginView-Ready")
            }
            it("should have expected layout loading state") {
                sut.frame = CGRect(x: 0, y: 0, width: 375, height: 667)
                sut.updateUI(state: .loading)
                expect(sut) == snapshot("LoginView-Loading")
            }
            it("should have expected layout error state") {
                sut.frame = CGRect(x: 0, y: 0, width: 375, height: 667)
                sut.updateUI(state: .error("Mensagem de erro XPTO"))
                expect(sut) == snapshot("LoginView-Error-Custom")
            }
        })
    }
}

