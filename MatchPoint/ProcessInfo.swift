//
//  ProcessInfo.swift
//  MatchPoint
//
//  Created by Douglas Medeiros on 01/12/17.
//  Copyright © 2017 Lucas Salton Cardinali. All rights reserved.
//

import Foundation

extension ProcessInfo {
    var isUITesting: Bool {
        return arguments.contains("isUITesting")
    }
}
