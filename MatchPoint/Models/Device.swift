//
//  Device.swift
//  MatchPoint
//
//  Created by Lucas Salton Cardinali on 13/09/17.
//  Copyright © 2017 Lucas Salton Cardinali. All rights reserved.
//
import Foundation

struct Device: Mappable {
    let cordova: String?
    let manafacturer: String?
    let model: String?
    let platform: String?
    let uuid: String?
    let version: String?
}
