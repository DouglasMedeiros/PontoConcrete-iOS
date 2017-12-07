//
//  CurrentUserSpec.swift
//  PontoConcreteTests
//
//  Created by Douglas Medeiros on 26/11/17.
//  Copyright © 2017 Lucas Salton Cardinali. All rights reserved.
//

import Quick
import Nimble
import KeychainSwift

@testable import PontoConcrete

class KeychainSwiftMock: KeychainSwift {
    
    var passedGetString = false
    var passedGetBool = false
    var passedSetString = false
    var passedSetBool = false
    var passedDeleteString = false
    
    override func get(_ key: String) -> String? {
        passedGetString = true
        return ""
    }
    
    override func getBool(_ key: String) -> Bool? {
        passedGetBool = true
        return true
    }
    
    override func set(_ value: String, forKey key: String, withAccess access: KeychainSwiftAccessOptions?) -> Bool {
        passedSetString = true
        return true
    }
    
    override func set(_ value: Bool, forKey key: String, withAccess access: KeychainSwiftAccessOptions?) -> Bool {
        passedSetBool = true
        return true
    }
    
    override func delete(_ key: String) -> Bool {
        passedDeleteString = true
        return true
    }
}

class CurrentUserSpec: QuickSpec {
    
    override func spec() {
        var sut: CurrentUser!
        var keychain: KeychainSwiftMock!
        
        describe("CurrentUser") {
            context("when creating") {
                
                beforeEach {
                    keychain = KeychainSwiftMock()
                    sut = CurrentUser.shared
                    sut.keychain = keychain
                }
                
                it("fetchUser") {
                    let user = sut.user()
                    expect(user).toNot(beNil())
                    expect(keychain.passedGetString).to(beTrue())
                }
                
                it("saveUser") {
                    let user = SessionData(token: "123", clientId: "321", email: "email@server.com")
                    sut.new(user: user)
                    expect(keychain.passedSetString).to(beTrue())
                }
                
                it("deleteUser") {
                    let userRemoved = sut.remove()
                    expect(userRemoved).to(beTrue())
                    expect(keychain.passedDeleteString).to(beTrue())
                }
                
                it("saveConfig") {
                    sut.saveConfigNotification(isEnabled: true)
                    expect(keychain.passedSetBool).to(beTrue())
                    
                    expect(sut.configNotification()).to(beTrue())
                }
            }
        }
    }
}



