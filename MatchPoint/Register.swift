//
//  Register.swift
//  MatchPoint
//
//  Created by Lucas Salton Cardinali on 13/09/17.
//  Copyright © 2017 Lucas Salton Cardinali. All rights reserved.
//
import Foundation

struct Register: Mappable {
    let timeCard: TimeCard?
    let path: String?
    let device: Device?
    let appVersion: String?
    
    private enum CodingKeys : String, CodingKey {
        case timeCard = "time_card"
        case path = "_path"
        case device = "_device"
        case appVersion = "_appVersion"
    }
}
