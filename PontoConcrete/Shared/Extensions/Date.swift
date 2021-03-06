//
//  Date.swift
//  PontoConcrete
//
//  Created by Douglas Medeiros on 15/11/17.
//  Copyright © 2017 Lucas Salton Cardinali. All rights reserved.
//

import Foundation

extension Date {
    func salutation() -> String {
        let hour = Calendar.current.component(.hour, from: self)
        var message = ""
        
        if hour >= 0 && hour <= 11 {
            message = "Bom Trabalho!"
        } else if hour >= 12 && hour <= 13 {
            message = "Bom Almoço!"
        } else if hour >= 14 && hour <= 16 {
            message = "Bom Trabalho!"
        } else if hour >= 17 && hour <= 23 {
            message = "Boa Volta!"
        }
        
        return message.uppercased()
    }
}
