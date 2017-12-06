//
//  Mappeable.swift
//  MatchPoint
//
//  Created by Douglas Brito de Medeiros on 07/11/17.
//  Copyright © 2017 Lucas Salton Cardinali. All rights reserved.
//

import Foundation

protocol Mappable: Decodable {
    init?(jsonString: String)
}

extension Mappable {
    init?(jsonString: String) {
        guard let data = jsonString.data(using: .utf8) else {
            return nil
        }
        
        do {
            self = try JSONDecoder().decode(Self.self, from: data)
        } catch {
            return nil
        }
        
    }
}
