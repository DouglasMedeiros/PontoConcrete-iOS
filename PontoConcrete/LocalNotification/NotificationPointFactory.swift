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
        switch point {
        case .saoPaulo:
            return NotificationPointSP(content: NotificationDefaultContent())
        case .rioDeJaneiro:
            return NotificationPointRJ(content: NotificationDefaultContent())
        case .minasGerais:
            return NotificationPointBH(content: NotificationDefaultContent())
        }
    }
}
