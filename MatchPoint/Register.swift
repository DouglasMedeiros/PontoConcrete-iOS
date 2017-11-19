//
//  Register.swift
//  MatchPoint
//
//  Created by Lucas Salton Cardinali on 13/09/17.
//  Copyright © 2017 Lucas Salton Cardinali. All rights reserved.
//
import Foundation

struct Register: Codable {
    var timeCard: TimeCard?
    var path: String?
    var device: Device?
    var appVersion: String?

    enum CodingKeys: String, CodingKey {
        case timeCard = "time_card"
        case path = "_path"
        case device = "_device"
        case appVersion = "_appVersion"
    }
}
