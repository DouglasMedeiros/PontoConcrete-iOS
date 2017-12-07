//
//  NotificationDefaultContent.swift
//  PontoConcrete
//
//  Created by Douglas Brito de Medeiros on 11/11/17.
//  Copyright © 2017 Lucas Salton Cardinali. All rights reserved.
//

import Foundation
import UserNotifications

class NotificationDefaultContent: UNMutableNotificationContent {
    override init() {
        super.init()
        self.title = "PontoConcrete"
        self.body = "Está chegando/saindo da Concrete? Não esqueça de bater o ponto!"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
