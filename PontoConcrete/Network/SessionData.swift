//
//  SessionData.swift
//  PontoConcrete
//
//  Created by Douglas Brito de Medeiros on 12/11/17.
//  Copyright © 2017 Lucas Salton Cardinali. All rights reserved.
//

import Foundation

public struct SessionData {
    let token: String
    let clientId: String
    let email: String
    
    func asDict() -> [String: String] {
        return [
            .command: .login,
            .token: token,
            .email: email,
            .clientId: clientId
        ]
    }
}
