//
//  LoggedInViewController.swift
//  PontoConcrete
//
//  Created by Lucas Salton Cardinali on 18/10/17.
//  Copyright © 2017 Lucas Salton Cardinali. All rights reserved.
//

import UIKit
import CoreLocation
import SwiftWatchConnectivity

protocol HomeViewControllerDelegate: class {
    func homeViewControllerDidLogout(viewController: HomeViewController)
}

fileprivate extension Selector {
    static let rememberTapped = #selector(HomeViewController.stateChanged(state:))
    static let logoutTapped = #selector(HomeViewController.didTapLogoutButton)
}

class HomeViewController: UIViewController {

    weak var delegate: HomeViewControllerDelegate?
    let containerView = HomeView()
    let location: LocationManager
    let userNotificationCenter: UserNotificationCenter
    let currentUser: CurrentUser
    let watchConnectivity: SwiftWatchConnectivity
    
    var uiAlertAction = UIAlertAction.self
    
    init(location: LocationManager = LocationManager(), userNotificationCenter: UserNotificationCenter = UserNotificationCenter(), currentUser: CurrentUser = CurrentUser.shared, watchConnectivity: SwiftWatchConnectivity = SwiftWatchConnectivity.shared) {
        self.location = location
        self.userNotificationCenter = userNotificationCenter
        self.currentUser = currentUser
        self.watchConnectivity = watchConnectivity
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
    
    func setupView() {
        containerView.logoutButton.addTarget(self, action: .logoutTapped, for: .touchUpInside)
        containerView.switchControl.addTarget(self, action: .rememberTapped, for: UIControlEvents.valueChanged)
        containerView.switchControl.isOn = CurrentUser.shared.configNotification()
    }
    
    @objc
    fileprivate func stateChanged(state: UISwitch) {        
        if state.isOn {
            self.requestLocationManager()
        } else {
            self.userNotificationCenter.removeAll()
        }
        self.currentUser.saveConfigNotification(isEnabled: state.isOn)
    }
    
    @objc
    func didTapLogoutButton() {
        let alert = UIAlertController(title: "Sair", message: "Tem certeza que deseja sair?", preferredStyle: .alert)
        let actionOK = self.uiAlertAction.createUIAlertAction(title: "Sim", style: .destructive, handler: {(_ ) in
            
            let data: [String: AnyObject] = [
                "command": "logout" as AnyObject
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
