//
//  TimeCard.swift
//  MatchPoint
//
//  Created by Lucas Salton Cardinali on 13/09/17.
//  Copyright © 2017 Lucas Salton Cardinali. All rights reserved.
//
import Foundation

struct TimeCard: Codable {
    var latitude: Double?
    var longitude: Double?
    var address: String?
    var referenceId: String?
    var originalLatitude: Double?
    var originalLongitude: Double?
    var originalAddress: String?
    var locationEdited: Bool?
    var accuracy: Int?

    enum CodingKeys: String, CodingKey {
        case latitude
        case longitude
        case address
        case referenceId = "reference_id"
        case originalLatitude
        case originalLongitude
        case originalAddress
        case locationEdited
        case accuracy
    }
}
