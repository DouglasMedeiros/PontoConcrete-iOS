//
//  LoginResponse.swift
//  MatchPoint
//
//  Created by Lucas Salton Cardinali on 13/09/17.
//  Copyright © 2017 Lucas Salton Cardinali. All rights reserved.
//
import Foundation

struct LoginResponse: Codable {
    var token: String?
    var clientId: String?

    enum CodingKeys: String, CodingKey {
        case token = "token"
        case clientId = "client_id"
    }
}
