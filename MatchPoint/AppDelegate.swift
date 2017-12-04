//
//  AppDelegate.swift
//  MatchPoint
//
//  Created by Lucas Salton Cardinali on 13/09/17.
//  Copyright © 2017 Lucas Salton Cardinali. All rights reserved.
//

import UIKit
import KeychainSwift
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        self.window = UIWindow(frame: UIScreen.main.bounds)

        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        let token = KeychainSwift().get("token")
        let initialViewController: UIViewController

        if let validToken = token, validToken != "" {
            initialViewController = storyboard.instantiateViewController(withIdentifier: "LoggedIn")
        } else {
            initialViewController = storyboard.instantiateViewController(withIdentifier: "Setup")
        }

        self.window?.rootViewController = initialViewController
        self.window?.makeKeyAndVisible()

        return true
    }
}
