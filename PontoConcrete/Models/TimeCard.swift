//
//  TimeCard.swift
//  PontoConcrete
//
//  Created by Lucas Salton Cardinali on 13/09/17.
//  Copyright © 2017 Lucas Salton Cardinali. All rights reserved.
//
import Foundation

struct TimeCard: Mappable {
    let latitude: Double?
    let longitude: Double?
    let address: String?
    let referenceId: String?
    let originalLatitude: Double?
    let originalLongitude: Double?
    let originalAddress: String?
    let locationEdited: Bool?
    let accuracy: Int?
    
    private enum CodingKeys: String, CodingKey {
        case latitude = "latitude"
        case longitude = "longitude"
        case address = "address"
        case referenceId = "reference_id"
        case originalLatitude = "originalLatitude"
        case originalLongitude = "originalLongitude"
        case originalAddress = "originalAddress"
        case locationEdited = "locationEdited"
        case accuracy = "accuracy"
    }
}
