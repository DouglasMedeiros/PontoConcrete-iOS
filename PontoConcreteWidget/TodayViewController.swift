//
//  TodayViewController.swift
//  PontoConcreteWidget
//
//  Created by Lucas Salton Cardinali on 13/09/17.
//  Copyright © 2017 Lucas Salton Cardinali. All rights reserved.
//

import UIKit
import NotificationCenter
import CoreLocation

fileprivate extension Selector {
    static let registerTapped = #selector(TodayViewController.didTapRegisterButton)
    static let reloadTapped = #selector(TodayViewController.didTapReloadButton)
    static let setupReadyView = #selector(TodayViewController.setupReadyView)
<<<<<<< Updated upstream
    static let setupErrorView = #selector(TodayViewController.setupErrorView)
=======
>>>>>>> Stashed changes
}

@objc (TodayViewController)
class TodayViewController: UIViewController {
    
    let geocoder = GGeocoderManager()
    let locationManager: LocationManager = LocationManager()
    let containerView = TodayView()
    
    let api = PontoMaisService()
    let currentUser: CurrentUser
    
    var pointData: PointData?
    var keychainData: SessionData?
    
    var timerStartup: Timer?
<<<<<<< Updated upstream
    var timerTimout: Timer?
=======
>>>>>>> Stashed changes
    
    init() {
        self.currentUser = CurrentUser.shared
        
        super.init(nibName: nil, bundle: nil)
        
        self.preferredContentSize = CGSize(width: 320, height: 110)
        self.extensionContext?.widgetLargestAvailableDisplayMode = .expanded
    }
    
    override func loadView() {
        view = containerView
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
<<<<<<< Updated upstream
        containerView.readyView.reloadAddressButton.addTarget(self, action: .reloadTapped, for: .touchUpInside)
=======
>>>>>>> Stashed changes
        containerView.readyView.registerButton.addTarget(self, action: .registerTapped, for: .touchUpInside)
        
        self.checkLogin()
    }
}

extension TodayViewController {
    
    private func register(credentials: SessionData, point: PointData) {
        self.api.register(credentials: credentials, point: point) { (response, result) in
            switch result {
            case .success:
                if response != nil {
                    self.containerView.updateUI(state: .success)
                    self.registerTimer()
                } else {
                    self.containerView.updateUI(state: .error(.request({
                        self.checkLogin()
                    })))
                }
            case .failure(let error):
                
                if case let .underlying(nsError as NSError, _) = error {
                    if nsError.code == URLError.notConnectedToInternet.rawValue {
                        let message = LabelAttributed.errorInternet
                        self.containerView.updateUI(state: .error(.custom(message, {
                            self.checkLogin()
                        })))
                        
                        return
                    }
                }
               
                self.containerView.updateUI(state: .error(.request({
                    self.checkLogin()
                })))
            }
        }
    }
}

extension TodayViewController {
    
    private func registerTimer() {
        self.timerStartup?.invalidate()
        timerStartup = Timer.scheduledTimer(timeInterval: 30, target: self,
                                     selector: .setupReadyView, userInfo: nil, repeats: false)
    }
    
<<<<<<< Updated upstream
    private func checkTimout() {
        self.timerTimout?.invalidate()
        timerTimout = Timer.scheduledTimer(timeInterval: 15, target: self,
                                            selector: .setupErrorView, userInfo: nil, repeats: false)
    }
    
=======
>>>>>>> Stashed changes
    @discardableResult
    func checkLogin() -> Bool {
        if self.currentUser.isLoggedIn() {
            self.keychainData = self.currentUser.user()
<<<<<<< Updated upstream
            self.requestLocationManager()
=======
>>>>>>> Stashed changes
            self.containerView.updateUI(state: .loading)
            return true
        } else {
            self.containerView.updateUI(state: .error(.login))
            return false
        }
    }
    
<<<<<<< Updated upstream
    private func setupLocationCallback() {
        self.locationManager.locationCallback = { (location, error) in
            if !self.currentUser.isLoggedIn() {
                self.containerView.updateUI(state: .error(.login))
                return
            }
            
            guard let location = location else {
                let message = LabelAttributed.custom(error?.localizedDescription ?? "Erro")
                self.containerView.updateUI(state: .error(.custom(message, {
                    self.requestLocationManager()
                })))
                return
            }
            
            self.geocoder.reverse(location: location, completeHandler: { (pointData, error) in
                if error != nil {
                    let message = LabelAttributed.errorGeocodeLocation
                    self.containerView.updateUI(state: .error(.custom(message, {
                        self.checkLogin()
                    })))
                } else {
                    guard let address = pointData?.address else { return }
                    self.pointData = pointData
                    self.timerTimout?.invalidate()
                    let message = LabelAttributed.address(address)
                    self.containerView.updateUI(state: .ready(.start(message)))
                }
            })
        }
    }
    
    private func setupAuthorizationStatusCallback() {
        self.locationManager.authorizationStatusCallback = { authorizationStatus in
            if authorizationStatus == .denied {
                let alert = UIAlertController(title: "Localização",
                                              message: "O acesso à localização foi negado, ative-a nas Configurações",
                                              preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                
                self.present(alert, animated: true, completion: nil)
            } else if CLLocationManager.authorizationStatus() == .notDetermined {
                self.locationManager.locationManager.requestWhenInUseAuthorization()
            } else if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
                self.locationManager.locationManager.requestLocation()
            }
        }
    }
    
    func requestLocationManager() {
        self.checkTimout()
        self.setupLocationCallback()
        self.setupAuthorizationStatusCallback()
        locationManager.requestAuthorization()
    }
    
    @objc
    func setupErrorView() {
        self.timerTimout?.invalidate()
        containerView.updateUI(state: .error(.custom(LabelAttributed.errorLocation, {
            self.checkLogin()
        })))
    }
    
=======
>>>>>>> Stashed changes
    @objc
    func setupReadyView() {
        self.timerStartup?.invalidate()
        containerView.updateUI(state: .loading)
<<<<<<< Updated upstream
        self.requestLocationManager()
=======
>>>>>>> Stashed changes
    }
    
    @objc
    func didTapReloadButton() {
<<<<<<< Updated upstream
        self.requestLocationManager()
=======
>>>>>>> Stashed changes
        containerView.updateUI(state: .loading)
    }
    
    @objc
    func didTapRegisterButton() {
        containerView.updateUI(state: .loading)
        
        guard let keychainData = self.keychainData, let pointData = self.pointData else {
            return
        }
        
        self.register(credentials: keychainData, point: pointData)
    }
}

extension TodayViewController: NCWidgetProviding {
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        completionHandler(self.checkLogin() ? .newData : .noData)
    }
}
