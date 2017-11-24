//
//  TodaySuccessView.swift
//  MatchPointWidget
//
//  Created by Douglas Medeiros on 19/11/17.
//  Copyright © 2017 Lucas Salton Cardinali. All rights reserved.
//

import UIKit
import SnapKit

class TodaySuccessView: UIView {
    
    lazy var containerView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = UIColor.white.withAlphaComponent(0.2)
        return view
    }()
    
    lazy var messageLabel: UILabel = {
        let lb = UILabel(frame: .zero)
        lb.textAlignment = .center
        return lb
    }()
    
    public init() {
        super.init(frame: .zero)
        setupViewConfiguration()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TodaySuccessView: ViewConfiguration {
    func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
        
        messageLabel.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
    }
    
    func buildViewHierarchy() {
        addSubview(containerView)
        containerView.addSubview(messageLabel)
    }
}
