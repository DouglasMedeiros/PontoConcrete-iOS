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
    static let setupReadyView = #selector(TodayViewController.setupReadyView)
}

@objc (TodayViewController)
class TodayViewController: UIViewController {
    
    let containerView = TodayView()
    
    let api = PontoMaisService()
    let currentUser: CurrentUser
    
    var pointData: PointData?
    var keychainData: SessionData?
    
    var timerStartup: Timer?
    
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
        
        containerView.readyView.registerButton.addTarget(self, action: .registerTapped, for: .touchUpInside)
        
        self.containerView.updateUI(state: .loading)
        
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

    @discardableResult
    func checkLogin() -> Bool {
        if self.currentUser.isLoggedIn() {
            self.keychainData = self.currentUser.user()
            self.containerView.updateUI(state: .loading)
            
            self.pointData = self.currentUser.configLocation().point()
            
            guard let address = self.pointData?.address else {
                return false
            }
            
            let message = LabelAttributed.address(address)
            self.containerView.updateUI(state: .ready(.start(message)))

            return true
        } else {
            self.containerView.updateUI(state: .error(.login))
            return false
        }
    }
    
    @objc
    func setupReadyView() {
        self.timerStartup?.invalidate()
        containerView.updateUI(state: .loading)
    }
    
    @objc
    func didTapReloadButton() {
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
