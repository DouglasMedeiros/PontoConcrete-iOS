//
//  HomeInterfaceController.swift
//  PontoConcrete WatchOS
//
//  Created by Douglas Medeiros on 19/11/17.
//  Copyright © 2017 Lucas Salton Cardinali. All rights reserved.
//

import WatchKit
import Foundation

class HomeInterfaceController: WKInterfaceController {
    
    public enum HomeInterfaceUIStateErrorType {
        case login
        case request
        case custom(LabelAttributed)
    }
    
    public enum HomeInterfaceUIState {
        case success
        case ready(LabelAttributed)
        case error(HomeInterfaceUIStateErrorType)
        case loading
    }
    
    lazy var geocoder: IGeocoderManager = {
        let manager = GGeocoderManager()
        return manager
    }()
    
    let location: LocationManager
    let service: PontoMaisService
    let watchConnectivity: SwiftWatchConnectivity
    
    var doneTimer: Timer?
    
    var pointData: PointData?
    var credentials: SessionData?
    
    @IBOutlet private(set) var separator: WKInterfaceSeparator?
    @IBOutlet private(set) var addressLabel: WKInterfaceLabel?
    @IBOutlet private(set) var reloadButton: WKInterfaceButton?
    @IBOutlet private(set) var registerButton: WKInterfaceButton?
    
    override init() {
        self.watchConnectivity = SwiftWatchConnectivity.shared
        self.service = PontoMaisService()
        self.location = LocationManager()
        super.init()

        awakeApp()
        
        addMenuItem(with: WKMenuItemIcon.resume, title: "Atualizar endereço", action: #selector(HomeInterfaceController.updateAddress))
    }
    
    private func sleepApp() {
        self.location.locationManager.stopUpdatingLocation()
        self.watchConnectivity.delegate = nil
    }
    private func awakeApp() {
        self.watchConnectivity.delegate = self
    }
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        self.awakeApp()
    }
   
    override func willDisappear() {
        super.willDisappear()
        self.sleepApp()
    }
    
    @objc
    func timerDone() {
        self.doneTimer?.invalidate()
        self.requestLocationManager()
    }
    
    override func willActivate() {
        self.awakeApp()
        
        if self.credentials == nil {
            self.updateUI(state: .loading)
            DispatchQueue.main.async {
                let data: [String: AnyObject] = [
                    .command: "login" as AnyObject
                ]
                self.watchConnectivity.sendMesssage(message: data)
            }
        }
        super.willActivate()
    }
}

extension HomeInterfaceController {
    @IBAction func updateAddress() {
        self.requestLocationManager()
    }
    
    @IBAction func registerPoint() {
        guard let credentials = self.credentials, let pointData = self.pointData else {
            return
        }
        
        self.register(credentials: credentials, point: pointData)
    }
}

extension HomeInterfaceController: SwiftWatchConnectivityDelegate {
    func connectivity(_ swiftWatchConnectivity: SwiftWatchConnectivity, updatedWithTask task: SwiftWatchConnectivity.Task) {
        
        if case let .sendMessage(message) = task {
            guard let command = message[.command] as? String else { return }
            
            switch command {
            case .logout:
                self.credentials = nil
                self.updateUI(state: .error(.login))
                
            case .login:
                guard let token = message[.token] as? String,
                    let clientId = message[.clientId] as? String,
                    let email = message[.email] as? String else {
                        return
                }
                self.credentials = SessionData(token: token, clientId: clientId, email: email)
                self.requestLocationManager()
                
            case .location:
                guard let location = message[.location] as? String else {
                    return
                }
                
                let address = LabelAttributed.custom(location)
                self.addressLabel?.setAttributedText(address.attributed())
            default:
                break
            }
        }
    }
}
extension HomeInterfaceController {
    
    @discardableResult
    private func checkLogin() -> Bool {
        let status = self.credentials != nil
        
        if !status {
            self.updateUI(state: .error(.login))
        }
        return status
    }
    
    private func setupLocationCallback() {
        self.location.locationCallback = { (location, error) in
            
            guard let location = location else {
                let message = LabelAttributed.custom(error?.localizedDescription ?? "Erro!")
                self.updateUI(state: .error(.custom(message)))
                return
            }
            
            self.location.locationManager.stopUpdatingLocation()
            
            self.updateUI(state: .loading)
            
            self.geocoder.reverse(location: location, completeHandler: { (pointData, error) in
                
                if error != nil {
                    guard let localizedDescription = error?.localizedDescription else {
                        return
                    }
                    self.updateUI(state: .error(.custom(.custom(localizedDescription))))
                }
                guard let address = pointData?.address, let pointData = pointData else {
                    return
                }
                
                self.pointData = pointData
                
                self.updateUI(state: .ready(.custom(address)))
            })
        }
    }
    
    private func setupAuthorizationStatusCallback() {
        self.location.authorizationStatusCallback = { authorizationStatus in
            if authorizationStatus == .denied {
                self.updateUI(state: .error(.custom(.permission)))
            } else if CLLocationManager.authorizationStatus() == .notDetermined {
                self.location.locationManager.requestWhenInUseAuthorization()
            } else if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
                self.location.locationManager.requestLocation()
                self.registerButton?.setEnabled(true)
            }
        }
    }
    
    private func requestLocationManager() {
        self.updateUI(state: .loading)
        self.setupAuthorizationStatusCallback()
        self.setupLocationCallback()
        self.location.requestAuthorization()
    }
    
    private func register(credentials: SessionData, point: PointData) {
        self.service.register(credentials: credentials, point: point) { (response, result) in
            switch result {
            case .success:
                if response != nil {
                    self.updateUI(state: .success)
                    
                    self.doneTimer = Timer.scheduledTimer(timeInterval: 15, target: self, selector: #selector(HomeInterfaceController.timerDone), userInfo: nil, repeats: false)
                } else {
                    self.updateUI(state: .error(.request))
                }
            case .failure(let error):
                
                if case let .underlying(nsError as NSError, _) = error {
                    if nsError.code == URLError.notConnectedToInternet.rawValue {
                        let message = LabelAttributed.custom(nsError.localizedDescription)
                        self.updateUI(state: .error(.custom(message)))
                        return
                    }
                }
                
                let message = LabelAttributed.custom(error.localizedDescription)
                self.updateUI(state: .error(.custom(message)))
            }
        }
    }
    
    private func updateUI(state: HomeInterfaceUIState) {
        self.addressLabel?.sizeToFitHeight()
        self.separator?.setHidden(true)
        self.registerButton?.setHidden(true)
        self.reloadButton?.setHidden(true)
        
        switch state {
        case .success:
            self.displaySuccess()
            
        case .loading:
            self.displayLoading()
            
        case .ready(let message):
            self.displayReady(message: message)
            
        case .error(let type):
            self.displayError(type: type)
        }
    }
    
    private func displaySuccess() {
        let message = LabelAttributed.salutationSuccess(time: Date())
        self.addressLabel?.setAttributedText(message.attributed())
        self.addressLabel?.setHeight(152)
    }
    
    private func displayLoading() {
        self.addressLabel?.setAttributedText(LabelAttributed.loading.attributed())
        self.addressLabel?.setHeight(152)
    }
    
    private func displayReady(message: LabelAttributed) {
        self.addressLabel?.setAttributedText(message.attributed())
        self.separator?.setHidden(false)
        self.registerButton?.setHidden(false)
        self.reloadButton?.setHidden(false)
    }
    
    private func displayError(type: HomeInterfaceUIStateErrorType) {
        var message: LabelAttributed
        
        switch type {
        case .login:
            message = .login
            self.addressLabel?.setHeight(152)
        case .request:
            message = .request
        case .custom(let customMessage):
            message = customMessage
        }
        
        self.addressLabel?.setAttributedText(message.attributed())
    }
}
