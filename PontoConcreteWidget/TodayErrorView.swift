//
//  TodayErrorView.swift
//  PontoConcreteWidget
//
//  Created by Douglas Medeiros on 16/11/17.
//  Copyright © 2017 Lucas Salton Cardinali. All rights reserved.
//

import UIKit
import SnapKit

fileprivate extension Selector {
    static let buttonTapped = #selector(TodayErrorView.actionButtonClicked)
}

class TodayErrorView: UIView {
    
    var actionButtonCallback: (() -> Void)?
    
    lazy var containerView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = UIColor.white.withAlphaComponent(0.2)
        return view
    }()
    
    lazy var messageLabel: UILabel = {
        let lb = UILabel(frame: .zero)
        lb.textAlignment = .center
        lb.numberOfLines = 2
        return lb
    }()
    
    lazy var tryButton: UIButton = { () -> UIButton in
        let bt = UIButton(frame: .zero)
        bt.setAttributedTitle(LabelAttributed.buttonTry.attributed(), for: .normal)
        bt.setTitleColor(.white, for: .normal)
        bt.cornerRadius = 12
        bt.backgroundColor = .catalinaBlue
        bt.addTarget(self, action: .buttonTapped, for: .touchUpInside)
        return bt
    }()
    
    public init() {
        super.init(frame: .zero)
        setupViewConfiguration()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TodayErrorView {
    
    @objc
    func actionButtonClicked() {
        actionButtonCallback?()
    }
    
    func updateUI(state: TodayUIStateErrorType) {
        switch state {
        case .login:
            self.messageLabel.attributedText = LabelAttributed.login.attributed()
            self.messageLabel.snp.remakeConstraints({ make in
                make.left.right.equalTo(self).inset(10)
                make.height.equalTo(44)
                make.centerY.equalToSuperview()
            })
            self.tryButton.isHidden = true
            
        case .request(let callback):
            self.messageLabel.attributedText = LabelAttributed.errorRequest.attributed()
            self.tryButton.isHidden = false
            self.actionButtonCallback = callback
            setupConstraints()
            
        case .custom(let message, let callback):
            self.messageLabel.attributedText = message.attributed()
            self.tryButton.isHidden = false
            self.actionButtonCallback = callback
            setupConstraints()
        }
    }
}

extension TodayErrorView: ViewConfiguration {
    func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
        
        messageLabel.snp.remakeConstraints { make in
            make.left.right.equalTo(self).inset(10)
            make.top.equalTo(10)
            make.height.equalTo(44)
        }
        
        tryButton.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(self).inset(5)
            make.top.equalTo(messageLabel.snp.bottom).offset(5)
        }
    }
    
    func buildViewHierarchy() {
        addSubview(containerView)
        containerView.addSubview(messageLabel)
        containerView.addSubview(tryButton)
    }
}
