//
//  Device.swift
//  MatchPoint
//
//  Created by Lucas Salton Cardinali on 13/09/17.
//  Copyright © 2017 Lucas Salton Cardinali. All rights reserved.
//
import Foundation

struct Device: Codable {
    var cordova: String?
    var manafacturer: String?
    var model: String?
    var platform: String?
    var uuid: String?
    var version: String?
}
