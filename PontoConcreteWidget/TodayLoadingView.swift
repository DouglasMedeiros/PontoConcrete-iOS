//
//  TodayLoadingView.swift
//  PontoConcreteWidget
//
//  Created by Douglas Medeiros on 18/11/17.
//  Copyright © 2017 Lucas Salton Cardinali. All rights reserved.
//

import UIKit
import SnapKit

class TodayLoadingView: UIView {
    lazy var containerView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = UIColor.white.withAlphaComponent(0.2)
        return view
    }()

    lazy fileprivate(set) var activityIndicator = { () -> UIActivityIndicatorView in
        let aiv = UIActivityIndicatorView(frame: .zero)
        aiv.hidesWhenStopped = true
        aiv.activityIndicatorViewStyle = .whiteLarge
        aiv.color = .catalinaBlue
        aiv.transform = CGAffineTransform(scaleX: 2, y: 2)
        return aiv
    }()

    public init() {
        super.init(frame: .zero)
        setupViewConfiguration()
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TodayLoadingView: ViewConfiguration {
    func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
        
        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    func buildViewHierarchy() {
        addSubview(containerView)
        containerView.addSubview(activityIndicator)
    }
}
