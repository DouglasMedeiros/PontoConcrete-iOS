//
//  AppCoordinator.swift
//  MatchPoint
//
//  Created by Douglas Brito de Medeiros on 11/11/17.
//  Copyright © 2017 Lucas Salton Cardinali. All rights reserved.
//
import UIKit

class AppCoordinator: RootViewCoordinator {
    
    var childCoordinators: [Coordinator] = []
    
    var rootViewController: UIViewController {
        return self.navigationController
    }
    
    let window: UIWindow
    
    private lazy var navigationController: UINavigationController = {
        let navigationController = UINavigationController()
        navigationController.isNavigationBarHidden = true
        return navigationController
    }()
    
    public init(window: UIWindow) {
        self.window = window
        
        self.window.rootViewController = self.rootViewController
        self.window.makeKeyAndVisible()
    }
    
    public func start() {
        if CurrentUser.shared.isLoggedIn() {
            self.showHomeViewController()
        } else {
            self.showLoginViewController()
        }
    }
    
    private func showLoginViewController() {
        let loginViewController = LoginViewController()
        loginViewController.delegate = self
        
        self.navigationController.viewControllers = [loginViewController]
    }
    
    private func showHomeViewController() {
        let homeViewController = HomeViewController()
        
        homeViewController.delegate = self
        self.navigationController.viewControllers = [homeViewController]
    }
    
}

extension AppCoordinator: HomeViewControllerDelegate {
    func homeViewControllerDidLogout(viewController: HomeViewController) {
        start()
    }
}

extension AppCoordinator: LoginViewControllerDelegate {
    func loginViewControllerDidTapAutenticate(viewController: LoginViewController) {
        start()
    }
}
