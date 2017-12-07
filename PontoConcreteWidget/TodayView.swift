//
//  TodayView.swift
//  PontoConcreteWidget
//
//  Created by Douglas Brito de Medeiros on 12/11/17.
//  Copyright © 2017 Lucas Salton Cardinali. All rights reserved.
//

import UIKit
import SnapKit

class TodayView: UIView {
    
    lazy var containerView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = UIColor.white.withAlphaComponent(0.2)
        return view
    }()
    
    lazy var successView: TodaySuccessView = { () -> TodaySuccessView in
        let view = TodaySuccessView()
        return view
    }()
    
    lazy var readyView: TodayReadyView = { () -> TodayReadyView in
        let view = TodayReadyView()
        return view
    }()
    
    lazy var errorView: TodayErrorView = { () -> TodayErrorView in
        let view = TodayErrorView()
        return view
    }()
    
    lazy var loadingView: TodayLoadingView = { () -> TodayLoadingView in
        let view = TodayLoadingView()
        return view
    }()
    
    public init() {
        super.init(frame: .zero)
        setupViewConfiguration()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

public enum TodayUIStateReadyType {
    case start(LabelAttributed)
    case custom(LabelAttributed)
}

public typealias RetryCallback = () -> Void

public enum TodayUIStateErrorType {
    case login
    case request(RetryCallback)
    case custom(LabelAttributed, RetryCallback)
}

public enum TodayUIState {
    case success
    case ready(TodayUIStateReadyType)
    case error(TodayUIStateErrorType)
    case loading
}

extension TodayView {
    
    func updateUI(state: TodayUIState) {
        self.successView.isHidden = true
        self.readyView.isHidden = true
        self.loadingView.isHidden = true
        self.errorView.isHidden = true
        
        switch state {
        case .success:
            self.displaySuccess()
            
        case .loading:
            self.displayLoading()
            
        case .ready(let type):
            self.displayReady(type: type)
            
        case .error(let type):
            self.displayError(type: type)
        }
    }
    
    private func displayReady(type: TodayUIStateReadyType) {
        self.readyView.isHidden = false
        self.containerView.isUserInteractionEnabled = true
        
        switch type {
        case .start(let address):
            self.readyView.addressLabel.attributedText = address.attributed()
            
            let title = LabelAttributed.start.attributed()
            self.readyView.registerButton.setAttributedTitle(title, for: .normal)
            
            self.readyView.registerButton.isEnabled = true
        case .custom(let message):
            self.readyView.registerButton.isEnabled = false
            self.readyView.registerButton.setAttributedTitle(message.attributed(), for: .normal)
            self.readyView.registerButton.backgroundColor = .successColor
        }
    }
    
    private func displayError(type: TodayUIStateErrorType) {
        self.containerView.isUserInteractionEnabled = true
        self.errorView.isHidden = false
        self.errorView.updateUI(state: type)
    }
    
    private func displayLoading() {
        self.loadingView.isHidden = false
        
        self.containerView.isUserInteractionEnabled = false
        self.loadingView.activityIndicator.startAnimating()
    }
    
    private func displaySuccess() {
        self.successView.isHidden = false
        let message = LabelAttributed.salutationSuccess(time: Date())
        self.successView.messageLabel.attributedText = message.attributed()
    }
}

extension TodayView: ViewConfiguration {
    func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
        
        successView.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
        
        readyView.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
        
        loadingView.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
        
        errorView.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
    }
    
    func buildViewHierarchy() {
        addSubview(containerView)
        containerView.addSubview(successView)
        containerView.addSubview(readyView)
        containerView.addSubview(loadingView)
        containerView.addSubview(errorView)
    }
}
