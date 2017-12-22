//
//  TodayReadyView.swift
//  PontoConcreteWidget
//
//  Created by Douglas Medeiros on 16/11/17.
//  Copyright © 2017 Lucas Salton Cardinali. All rights reserved.
//

import UIKit
import SnapKit

class TodayReadyView: UIView {
    lazy var containerView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = UIColor.white.withAlphaComponent(0.2)
        return view
    }()

    lazy var addressLabel: UILabel = {
        let lb = UILabel(frame: .zero)
        lb.numberOfLines = 2
        return lb
    }()

    lazy var registerButton: UIButton = { () -> UIButton in
        let view = UIButton(frame: .zero)
        view.cornerRadius = 12
        view.backgroundColor = .catalinaBlue
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

extension TodayReadyView: ViewConfiguration {
    func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
        
        addressLabel.snp.makeConstraints { make in
            make.left.right.equalTo(10)
            make.height.equalTo(40)
            make.top.equalTo(5)
        }
        
        registerButton.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(self).inset(5)
            make.top.equalTo(self).inset(45)
        }
    }
    
    func buildViewHierarchy() {
        addSubview(containerView)
        containerView.addSubview(addressLabel)
        containerView.addSubview(registerButton)
    }
}
