//
//  CurrentUser.swift
//  PontoConcrete
//
//  Created by Douglas Medeiros on 15/11/17.
//  Copyright © 2017 Lucas Salton Cardinali. All rights reserved.
//

import KeychainSwift
import CoreLocation

protocol CurrentUserProtocol: class {
    func isLoggedIn() -> Bool
    func user() -> SessionData?
}

class CurrentUser: CurrentUserProtocol {
    
    var keychain: KeychainSwift
    
    static let shared = CurrentUser()
    
    public init(keychain: KeychainSwift = KeychainSwift()) {
        self.keychain = keychain
    }
    
    func isLoggedIn() -> Bool {
        guard let token = keychain.get(.token) else {
            return false
        }
        
        return !token.isEmpty
    }
    
    func user() -> SessionData? {
        guard let token = keychain.get(.token),
            let clientId = keychain.get(.clientId),
            let email = keychain.get(.email) else {
                return nil
        }
        return SessionData(token: token, clientId: clientId, email: email)
    }
    
    @discardableResult
    func saveConfigNotification(isEnabled: Bool) -> Bool {
        return self.keychain.set(isEnabled, forKey: .notification, withAccess: .accessibleAfterFirstUnlock)
    }
    
    func configNotification() -> Bool {
        guard let notification = keychain.getBool(.notification) else {
                return false
        }
        
        return notification
    }
    
    @discardableResult
    func new(user: SessionData) -> Bool {
        return self.keychain.set(user.token, forKey: .token, withAccess: .accessibleAfterFirstUnlock) && self.keychain.set(user.clientId, forKey: .clientId, withAccess: .accessibleAfterFirstUnlock) && self.keychain.set(user.email, forKey: .email, withAccess: .accessibleAfterFirstUnlock)
    }
    
    @discardableResult
    func remove() -> Bool {
        return self.keychain.delete(.token) && self.keychain.delete(.clientId)
    }

}
