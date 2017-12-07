//
//  LogoView.swift
//  PontoConcrete
//
//  Created by Douglas Brito de Medeiros on 11/11/17.
//  Copyright © 2017 Lucas Salton Cardinali. All rights reserved.
//

import UIKit
import SnapKit

final public class LogoView: UIView {
    
    lazy var containerView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .clear
        return view
    }()
    
    lazy var clockImage: UIImageView = {
        let image = UIImage(named: "Logo")
        let imageView = UIImageView(image: image)
        return imageView
    }()
    
    lazy var matchLabel: UILabel = {
        let lb = UILabel(frame: .zero)
        lb.font = UIFont.avenirHeavy.withSize(36)
        lb.text = "MATCH"
        lb.textColor = .white
        return lb
    }()
    
    lazy var pointLabel: UILabel = {
        let lb = UILabel(frame: .zero)
        lb.font = UIFont.avenirHeavy.withSize(40)
        lb.text = "POINT"
        lb.textColor = .white
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

extension LogoView: ViewConfiguration {
    func buildViewHierarchy() {
        
        addSubview(containerView)
        containerView.addSubview(matchLabel)
        containerView.addSubview(pointLabel)
        containerView.addSubview(clockImage)
    }
    
    func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.left.equalTo(0)
            make.top.equalTo(0)
            make.width.equalTo(164)
            make.height.equalTo(105)
        }
        
        matchLabel.snp.makeConstraints { make in
            make.left.equalTo(33)
            make.top.equalTo(38)
            make.width.equalTo(136)
            make.height.equalTo(36)
        }
        
        pointLabel.snp.makeConstraints { make in
            make.left.equalTo(38)
            make.top.equalTo(69)
            make.width.equalTo(126)
            make.height.equalTo(36)
        }
        
        clockImage.snp.makeConstraints { make in
            make.left.top.equalTo(0)
            make.width.height.equalTo(66)
        }
    }
    
}
