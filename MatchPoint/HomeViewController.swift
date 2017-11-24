//
//  LoggedInViewController.swift
//  MatchPoint
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
    
    init(location: LocationManager = LocationManager(), userNotificationCenter: UserNotificationCenter = UserNotificationCenter()) {
        self.location = location
        self.userNotificationCenter = userNotificationCenter
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
                let alert = UIAlertController(title: "Localização",
                                              message: "O acesso à localização foi negado, ative-a nas Configurações",
                                              preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                
                self.present(alert, animated: true, completion: nil)
            } else if CLLocationManager.authorizationStatus() == .notDetermined {
                self.location.locationManager.requestWhenInUseAuthorization()
            } else if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
                self.userNotificationCenter.requestNotifications()
            }
        }
        
        location.locationCallback = { (location) in
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
    func stateChanged(state: UISwitch) {        
        if state.isOn {
            self.requestLocationManager()
        } else {
            self.userNotificationCenter.removeAll()
        }
        CurrentUser.shared.saveConfigNotification(isEnabled: state.isOn)
    }
    
    @objc
    func didTapLogoutButton() {
        let alert = UIAlertController(title: "Sair",
                                      message: "Tem certeza que deseja sair?",
                                      preferredStyle: UIAlertControllerStyle.alert)
        
        let actionYes = UIAlertAction(title: "Sim",
                                      style: UIAlertActionStyle.destructive,
                                      handler: { _ in
                        
            let data: [String: AnyObject] = [
                "command": "logout" as AnyObject
            ]
                                        
            SwiftWatchConnectivity.shared.sendMesssage(message: data)
            
            CurrentUser.shared.remove()
            
            self.delegate?.homeViewControllerDidLogout(viewController: self)
            
        })
        alert.addAction(actionYes)
        
        let actionNot = UIAlertAction(title: "Não", style: .cancel, handler: nil)
        alert.addAction(actionNot)
        
        self.present(alert, animated: true, completion: nil)
    }
}
