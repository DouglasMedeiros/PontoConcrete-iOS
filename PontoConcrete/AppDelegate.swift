//
//  AppDelegate.swift
//  PontoConcrete
//
//  Created by Lucas Salton Cardinali on 13/09/17.
//  Copyright © 2017 Lucas Salton Cardinali. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var appCoordinator: AppCoordinator?

    var swiftWatchConnectivity: SwiftWatchConnectivity?
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        if ProcessInfo.processInfo.isUITesting {
            UIView.setAnimationsEnabled(false)
            CurrentUser.shared.remove()
        }
        
<<<<<<< Updated upstream
        self.swiftWatchConnectivity = SwiftWatchConnectivity.shared
        self.swiftWatchConnectivity?.delegate = self
=======
        
        
        self.swiftWatchConnectivity = WatchConnectivityManager()
        self.swiftWatchConnectivity?.start()
>>>>>>> Stashed changes
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        
        self.window = window
        self.appCoordinator = AppCoordinator(window: window)
        self.appCoordinator?.start()
        
        return true
    }
}

extension AppDelegate: SwiftWatchConnectivityDelegate {
    func connectivity(_ swiftWatchConnectivity: SwiftWatchConnectivity, updatedWithTask task: SwiftWatchConnectivity.Task) {
        
        if case .sendMessage = task {
            guard let currentUser = CurrentUser.shared.user() else {
                
                let data: [String: AnyObject] = [
                    .command: "logout" as AnyObject
                ]
                
                DispatchQueue.main.async {
                    self.swiftWatchConnectivity?.sendMesssage(message: data)
                }
                return
            }
            
            DispatchQueue.main.async {
                self.swiftWatchConnectivity?.sendMesssage(message: currentUser.asDict())
            }
        }
        
    }
}
