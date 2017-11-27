//
//  HomeView.swift
//  MatchPoint
//
//  Created by Douglas Brito de Medeiros on 11/11/17.
//  Copyright © 2017 Lucas Salton Cardinali. All rights reserved.
//

import SnapKit

class HomeView: UIView {
    lazy var backgroundImage: UIImageView = {
        let image = UIImage(named: "bg")
        let imageView = UIImageView(image: image)
        return imageView
    }()
    
    lazy var containerView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .clear
        return view
    }()
    
    lazy var logoView: LogoView = {
        let logoView = LogoView()
        return logoView
    }()
    
    lazy var infoLabel: UILabel = {
        let lb = UILabel(frame: .zero)
        lb.font = UIFont.systemFont(ofSize: 17)
        lb.numberOfLines = 2
        lb.textColor = .white
        lb.text = "Pronto! Agora só basta adicionar o widget a sua tela de notificações."
        return lb
    }()
    
    lazy var tutorialImage: UIImageView = {
        let image = UIImage(named: "tutorial")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var containerRememberView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .clear
        return view
    }()
    
    lazy var rememberLabel: UILabel = {
        let lb = UILabel(frame: .zero)
        lb.font = UIFont.systemFont(ofSize: 17)
        lb.textColor = .white
        lb.text = "Lembrar de bater o ponto"
        return lb
    }()
    
    lazy var switchControl: UISwitch = { () -> UISwitch in
        let view = UISwitch(frame: .zero)
        return view
    }()
    
    lazy var logoutButton: UIButton = { () -> UIButton in
        let view = UIButton(frame: .zero)
        view.setTitle("Sair", for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.titleLabel?.font = .systemFont(ofSize: 17)
        view.borderColor = .white
        view.borderWidth = 1
        view.cornerRadius = 10
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

extension HomeView: ViewConfiguration {
    func buildViewHierarchy() {
        addSubview(containerView)
        containerView.addSubview(backgroundImage)
        containerView.addSubview(logoView)
        containerView.addSubview(infoLabel)
        containerView.addSubview(tutorialImage)
        containerView.addSubview(containerRememberView)
        containerRememberView.addSubview(rememberLabel)
        containerRememberView.addSubview(switchControl)
        containerView.addSubview(logoutButton)
    }
    
    func setupConstraints() {
        backgroundImage.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
        
        containerView.snp.makeConstraints { make in
            make.left.top.right.bottom.equalTo(self)
        }
        
        logoView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(50)
            make.width.equalTo(164)
            make.height.equalTo(105)
        }
        
        infoLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(logoView.snp.bottom).inset(-30)
            make.width.equalTo(279)
            make.height.equalTo(46)
        }
        
        tutorialImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(infoLabel.snp.top).inset(30)
            make.width.equalTo(315)
            make.height.equalTo(343)
        }
        
        containerRememberView.snp.makeConstraints { make in
            make.centerX.equalTo(self)
            make.bottom.equalTo(logoutButton.snp.top).inset(-25)
            make.width.equalTo(270)
            make.height.equalTo(32)
        }
        
        rememberLabel.snp.makeConstraints { make in
            make.left.equalTo(0)
            make.top.equalTo(0)
            make.width.equalTo(204)
            make.height.equalTo(32)
        }
        
        switchControl.snp.makeConstraints { make in
            make.left.equalTo(216)
            make.top.equalTo(0)
            make.width.equalTo(49)
            make.height.equalTo(31)
        }
        
        logoutButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.left.right.equalTo(0).inset(20)
            make.bottom.equalTo(0).inset(20)
        }
    }
}
