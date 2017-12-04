//
//  LoggedInViewController.swift
//  MatchPoint
//
//  Created by Lucas Salton Cardinali on 18/10/17.
//  Copyright © 2017 Lucas Salton Cardinali. All rights reserved.
//

import UIKit
import KeychainSwift
import CoreLocation
import UserNotifications

class LoggedInViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak private(set) var rememberNotificationSwitch: UISwitch?
    @IBOutlet weak private(set) var logoutButton: UIButton?

    @IBOutlet weak private(set) var rememberSwitch: UISwitch?
    let center = UNUserNotificationCenter.current()
    let options: UNAuthorizationOptions = [.alert, .sound]

    let locationManager = CLLocationManager() // Add this statement

    override func viewDidLoad() {
        super.viewDidLoad()

        rememberSwitch?.addTarget(self, action: #selector(stateChanged(state:)), for: UIControlEvents.valueChanged)

        locationManager.delegate = self
        locationManager.distanceFilter = kCLLocationAccuracyNearestTenMeters
        locationManager.desiredAccuracy = kCLLocationAccuracyBest

    }

    @objc
    func stateChanged(state: UISwitch) {
        if state.isOn {
            requestLocation()
        } else {
            UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        requestLocation()
    }

    func requestLocation() {
        if CLLocationManager.authorizationStatus() == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
        } else if CLLocationManager.authorizationStatus() == .denied {
            let message = "O acesso à localização foi negado, ative-a nas Configurações"
            let alert = UIAlertController(title: "Localização", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))

            self.present(alert, animated: true, completion: nil)
        } else if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            requestNotifications()
        }
    }

    func requestNotifications() {
        center.requestAuthorization(options: options) { (granted, _ error) in
            if !granted {
                print("Something went wrong")
            } else {
                self.setupNotifications()
            }
        }
    }

    // MARK: CLLocationManagerDelegate

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            self.requestNotifications()
        }
    }

    func setupNotifications() {
        
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        
        center.add(self.buildNotificationRequest(identifier: "ConcreteSP", latitude: -23.601449, longitude: -46.694799))
        center.add(self.buildNotificationRequest(identifier: "ConcreteRJ", latitude: -22.910222, longitude: -43.172658))
        center.add(self.buildNotificationRequest(identifier: "ConcreteSP", latitude: -19.935331, longitude: -43.929717))
        
    }
    
    private func buildNotificationRequest(identifier: String,
                                          latitude: Float,
                                          longitude: Float) -> UNNotificationRequest {
        let content = UNMutableNotificationContent()
        content.title = "Matchpoint"
        content.body = "Está chegando/saindo da Concrete? Não esqueça de bater o ponto!"
        
        let coordinates = CLLocationCoordinate2D(latitude: -23.601449, longitude: -46.694799)
        let coordinatesRegion = CLCircularRegion(center: coordinates, radius: 100, identifier: identifier)
        coordinatesRegion.notifyOnExit = true
        coordinatesRegion.notifyOnEntry = true
        
        let trigger = UNLocationNotificationTrigger(region: coordinatesRegion, repeats: true)
        
        let notification = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        return notification
    }

    @IBAction func didTapLogoutButton(_ sender: Any) {
        let alert = UIAlertController(title: "Sair", message: "Tem certeza que deseja sair?", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Sim", style: .destructive, handler: { _ in
            self.logout()
        }))

        alert.addAction(UIAlertAction(title: "Não", style: .cancel, handler: nil))

        self.present(alert, animated: true, completion: nil)
    }

    func logout() {
        let keychain = KeychainSwift()
        keychain.set("", forKey: "token")
        keychain.set("", forKey: "clientId")
        self.performSegue(withIdentifier: "logout", sender: self)
    }

}
