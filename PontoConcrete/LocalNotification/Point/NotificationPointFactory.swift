//
//  NotificationPointFactory.swift
//  PontoConcrete
//
//  Created by Douglas Brito de Medeiros on 11/11/17.
//  Copyright © 2017 Lucas Salton Cardinali. All rights reserved.
//

import Foundation

enum NotificationPointFactory {
    static func notification(for point: Point) -> NotificationPoint {
        let content = NotificationDefaultContent()
        
        switch point {
        case .saoPaulo:
            return NotificationPointSP(content: content)
        case .rioDeJaneiro:
            return NotificationPointRJ(content: content)
        case .minasGerais:
            return NotificationPointBH(content: content)
        }
    }
}
