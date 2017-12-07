//
//  WatchConnectivityManager.swift
//  PontoConcrete
//
//  Created by Douglas Medeiros on 02/12/17.
//  Copyright © 2017 Lucas Salton Cardinali. All rights reserved.
//

import Foundation
import SwiftWatchConnectivity

class WatchConnectivityManager: NSObject {
    let watchConnectivity: SwiftWatchConnectivity
    
    init(watchConnectivity: SwiftWatchConnectivity = SwiftWatchConnectivity.shared) {
        self.watchConnectivity = watchConnectivity
        super.init()
    }
    
    func start() {
        self.watchConnectivity.delegate = self
    }
}

extension WatchConnectivityManager: SwiftWatchConnectivityDelegate {
    func connectivity(_ swiftWatchConnectivity: SwiftWatchConnectivity, updatedWithTask task: SwiftWatchConnectivity.Task) {
        
        if case .sendMessage = task {
            guard let currentUser = CurrentUser.shared.user() else {
                
                let data: [String: AnyObject] = [
                    .command: "logout" as AnyObject
                ]
                
                DispatchQueue.main.async {
                    self.watchConnectivity.sendMesssage(message: data)
                }
                return
            }
            
            DispatchQueue.main.async {
                self.watchConnectivity.sendMesssage(message: currentUser.asDict())
            }
        }
    }
}
