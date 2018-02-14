//
//  LoggedInViewController.swift
//  PontoConcrete
//
//  Created by Lucas Salton Cardinali on 18/10/17.
//  Copyright © 2017 Lucas Salton Cardinali. All rights reserved.
//

import UIKit
import CoreLocation

protocol HomeViewControllerDelegate: class {
    func homeViewControllerDidLogout(viewController: HomeViewController)
}

fileprivate extension Selector {
    static let changeLocationTapped = #selector(HomeViewController.changeLocationDefault)
    static let logoutTapped = #selector(HomeViewController.didTapLogoutButton)
}

class HomeViewController: UIViewController {

    weak var delegate: HomeViewControllerDelegate?
    let containerView = HomeView()
    let location: LocationManager
    let userNotificationCenter: UserNotificationCenter
    let currentUser: CurrentUser
    let watchConnectivity: SwiftWatchConnectivity
    let firstLaunch: FirstLaunch
    
    let notificationCenter = NotificationCenter.default
    
    var uiAlertAction = UIAlertAction.self
    
    init(location: LocationManager = LocationManager(), userNotificationCenter: UserNotificationCenter = UserNotificationCenter(), currentUser: CurrentUser = CurrentUser.shared, watchConnectivity: SwiftWatchConnectivity = SwiftWatchConnectivity.shared) {
        self.location = location
        self.userNotificationCenter = userNotificationCenter
        self.currentUser = currentUser
        self.watchConnectivity = watchConnectivity
        
        #if DEBUG
            let source = AlwaysFirstLaunchDataSource()
        #else
            let source = UserDefaultsFirstLaunchDataSource(defaults: .standard, key: .firstLaunch)
        #endif
        
        self.firstLaunch = FirstLaunch(source: source)
        
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        view = containerView
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        requestLocationManager()
    }
}

extension HomeViewController {
    func requestLocationManager() {
        location.authorizationStatusCallback = { authorizationStatus in
            if authorizationStatus == .denied {
                let alert = UIAlertController(title: "Localização", message: "O acesso à localização foi negado, ative-a nas Configurações", preferredStyle: .alert)
                let actionOk = self.uiAlertAction.createUIAlertAction(title: "Ok", style: .default, handler: nil)
                alert.addAction(actionOk)
                self.present(alert, animated: true, completion: nil)
            } else if CLLocationManager.authorizationStatus() == .notDetermined {
                self.location.locationManager.requestWhenInUseAuthorization()
            } else if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
                self.userNotificationCenter.requestNotifications()
            }
        }
        
        location.locationCallback = { (location, error) in
            guard location != nil else {
                return
            }
            self.userNotificationCenter.requestNotifications()
        }
        
        location.requestAuthorization()
    }
    
    @objc
    func changeLocation(notification: Notification) {
        guard let userInfo = notification.userInfo as? [String: Any] else {
            return
        }
        
        guard let location = userInfo["location"] as? String, let point = Point(rawValue: location) else {
            return
        }
        
        self.containerView.updateUI(state: .location(point))
        self.currentUser.saveLocation(point: point)
    }
    
    func setupView() {
        
        notificationCenter.addObserver(self, selector: #selector(HomeViewController.changeLocation), name: .locationChanged, object: nil)
        
        containerView.changeLocationButton.addTarget(self, action: .changeLocationTapped, for: .touchUpInside)
        containerView.logoutButton.addTarget(self, action: .logoutTapped, for: .touchUpInside)
        
        if self.firstLaunch.isFirstLaunch {
            self.containerView.updateUI(state: .startup)
            self.changeLocationDefault()
        } else {
            let point = self.currentUser.configLocation()
            self.containerView.updateUI(state: .location(point))
        }
    }
    
    @objc
    fileprivate func changeLocationDefault() {
        
        let alert = UIAlertController(title: nil, message: "Selecione a sua sede", preferredStyle: .alert)
        
        for point in Point.cases() {
            let action = self.uiAlertAction.createUIAlertAction(title: point.name(), style: .default, handler: {(_ ) in
                self.containerView.updateUI(state: .location(point))
                self.currentUser.saveLocation(point: point)
                
                let data: [String: String] = [
                    .command: .location,
                    .location: point.rawValue
                ]
                
                self.watchConnectivity.sendMesssage(message: data)
            })
            alert.addAction(action)
        }
        
        if !self.firstLaunch.isFirstLaunch {
            let actionCancel = self.uiAlertAction.createUIAlertAction(title: "Cancelar", style: .cancel, handler: {(_ ) in
                
            })
            alert.addAction(actionCancel)
        }
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc
    func didTapLogoutButton() {
        let alert = UIAlertController(title: "Sair", message: "Tem certeza que deseja sair?", preferredStyle: .alert)
        
        let actionOK = self.uiAlertAction.createUIAlertAction(title: "Sim", style: .destructive, handler: {(_ ) in
            
            let data: [String: String] = [
                .command: .logout
            ]
            
            self.watchConnectivity.sendMesssage(message: data)
            
            self.currentUser.remove()
            
            self.delegate?.homeViewControllerDidLogout(viewController: self)
        })
        alert.addAction(actionOK)
        
        let actionCancel = self.uiAlertAction.createUIAlertAction(title: "Não", style: .default, handler: {(_ ) in
            
        })
        alert.addAction(actionCancel)
        self.present(alert, animated: true, completion: nil)
    }
    
}
