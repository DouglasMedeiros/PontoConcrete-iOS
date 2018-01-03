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

    var swiftWatchConnectivity: WatchConnectivityManager?
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        if ProcessInfo.processInfo.isUITesting {
            UIView.setAnimationsEnabled(false)
            CurrentUser.shared.remove()
        }
        
        self.swiftWatchConnectivity = WatchConnectivityManager()
        self.swiftWatchConnectivity?.start()
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        
        self.window = window
        self.appCoordinator = AppCoordinator(window: window)
        self.appCoordinator?.start()
        
        return true
    }
}

