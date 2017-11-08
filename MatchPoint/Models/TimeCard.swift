//
//  TimeCard.swift
//  MatchPoint
//
//  Created by Lucas Salton Cardinali on 13/09/17.
//  Copyright © 2017 Lucas Salton Cardinali. All rights reserved.
//
import Foundation

struct TimeCard: Mappable {
    let latitude: Double?
    let longitude: Double?
    let address: String?
    let reference_id: String?
    let originalLatitude: Double?
    let originalLongitude: Double?
    let originalAddress: String?
    let locationEdited: Bool?
    let accuracy: Int?
}
