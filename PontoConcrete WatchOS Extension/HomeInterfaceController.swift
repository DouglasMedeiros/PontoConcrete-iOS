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
    
    let service: PontoMaisService
    let watchConnectivity: SwiftWatchConnectivity
    
    var doneTimer: Timer?
    
    var pointData: PointData?
    var credentials: SessionData?
    
    @IBOutlet private(set) var separator: WKInterfaceSeparator?
    @IBOutlet private(set) var addressLabel: WKInterfaceLabel?
    @IBOutlet private(set) var registerButton: WKInterfaceButton?
    
    override init() {
        self.watchConnectivity = SwiftWatchConnectivity.shared
        self.service = PontoMaisService()
        super.init()

        awakeApp()
        
        for point in Point.cases() {
            var selector: Selector
            var imageName: String
            
            switch point {
                case .saoPaulo:
                    imageName = "brasao-sp"
                    selector = #selector(HomeInterfaceController.updateHeadquarterSP)
                case .rioDeJaneiro:
                    imageName = "brasao-rj"
                    selector = #selector(HomeInterfaceController.updateHeadquarterRJ)
                case .minasGerais:
                    imageName = "brasao-bh"
                    selector = #selector(HomeInterfaceController.updateHeadquarterMG)
            }
            guard let image = UIImage(named: imageName) else {
                return
            }
            
            self.addMenuItem(with: image, title: point.name(), action: selector)
        }
    }
    
    private func sleepApp() {
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
    func updateHeadquarterSP() {
        let point = Point.saoPaulo
        self.updateHeadquarter(point: point)
    }
    
    @objc
    func updateHeadquarterRJ() {
        let point = Point.rioDeJaneiro
        self.updateHeadquarter(point: point)
    }
    
    @objc
    func updateHeadquarterMG() {
        let point = Point.minasGerais
        self.updateHeadquarter(point: point)
    }
    
    private func updateHeadquarter(point: Point) {
        DispatchQueue.main.async {
            let data: [String: String] = [
                .command: .headquarter,
                .headquarter: point.rawValue
            ]
            self.watchConnectivity.sendMesssage(message: data)
            
            let address = LabelAttributed.custom(point.point().address)
            self.updateUI(state: .ready(.custom(address.attributed().string)))
        }
    }
    
    @objc
    func timerDone() {
        self.doneTimer?.invalidate()
    }
    
    override func willActivate() {
        self.awakeApp()
        
        if self.credentials == nil {
            self.updateUI(state: .loading)
            DispatchQueue.main.async {
                let data: [String: String] = [
                    .command: .login
                ]
                self.watchConnectivity.sendMesssage(message: data)
            }
        }
        super.willActivate()
    }
}

extension HomeInterfaceController {
    
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
                
                DispatchQueue.main.async {
                    let data: [String: String] = [
                        .command: .location
                    ]
                    self.watchConnectivity.sendMesssage(message: data)
                }

            case .location:
                guard let location = message[.location] as? String, let point = Point(rawValue: location) else {
                    return
                }
                
                let address = LabelAttributed.custom(point.point().address)
                self.updateUI(state: .ready(.custom(address.attributed().string)))
                
            case .headquarter:
                guard let location = message[.location] as? String, let point = Point(rawValue: location) else {
                    return
                }
                
                let address = LabelAttributed.custom(point.point().address)
                self.updateUI(state: .ready(.custom(address.attributed().string)))
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
