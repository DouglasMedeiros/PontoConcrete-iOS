//
//  SessionDataSpec.swift
//  PontoConcreteTests
//
//  Created by Douglas Medeiros on 25/11/17.
//  Copyright © 2017 Lucas Salton Cardinali. All rights reserved.
//

import Quick
import Nimble

@testable import PontoConcrete

class SessionDataSpec: QuickSpec {
    override func spec() {
        
        var sut: SessionData!
        
        it("should be able to create a instance of SessionData") {
            
            let token = "abc123"
            let clientId = "def432"
            let email = "email@email.com.br"
            sut = SessionData(token: token, clientId: clientId, email: email)
            
            expect(sut).toNot(beNil())
        }
        
        it("should be able to return dictonary") {
            
            let data = sut.asDict()
            let dict: [String: String] = [
                .command: .login,
                .token: "abc123",
                .email: "email@email.com.br",
                .clientId: "def432"
            ]
            
            let command = data[.command] as! String
            let commandExpect = dict[.command] as! String
            
            expect(command).to(equal(commandExpect))
            
            let token = data[.token] as! String
            let tokenExpect = dict[.token] as! String
            
            expect(token).to(equal(tokenExpect))
        }
    }
}
