//
//  HomeView.swift
//  PontoConcrete
//
//  Created by Douglas Brito de Medeiros on 11/11/17.
//  Copyright © 2017 Lucas Salton Cardinali. All rights reserved.
//

import UIKit
import SnapKit

class HomeView: UIView {
    lazy var backgroundImage: UIImageView = {
        let image = UIImage(named: "bg")
        let imageView = UIImageView(image: image)
        return imageView
    }()
    
    lazy var highlights: UIScrollView = {
        let view = UIScrollView(frame: .zero)
        return view
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
    
    lazy var changeLocationButton: UIButton = { () -> UIButton in
        let view = UIButton(frame: .zero)
        view.setTitle("Meu local: São Paulo", for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.titleLabel?.font = .systemFont(ofSize: 15)
        view.accessibilityIdentifier = "location"
        view.accessibilityLabel = "location"
        view.isAccessibilityElement = true
        view.accessibilityTraits = UIAccessibilityTraitButton
        view.backgroundColor = UIColor(red:0.11, green:0.24, blue:0.55, alpha:1.00)
        view.borderColor = UIColor.white.withAlphaComponent(0.5)
        view.borderWidth = 1
        view.cornerRadius = 10
        return view
    }()
    
    lazy var logoutButton: UIButton = { () -> UIButton in
        let view = UIButton(frame: .zero)
        view.setTitle("Sair", for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.titleLabel?.font = .systemFont(ofSize: 17)
        view.accessibilityIdentifier = "sair"
        view.accessibilityLabel = "sair"
        view.isAccessibilityElement = true
        view.accessibilityTraits = UIAccessibilityTraitButton
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

public enum HomeViewUIState {
    case startup
    case location(Point)
}

extension HomeView {
    
    func updateUI(state: HomeViewUIState) {
        switch state {
        case .startup:
            self.changeLocationButton.setTitle("Selecione...", for: .normal)
        case .location(let location):
            let title = LabelAttributed.location(location.name())
            self.changeLocationButton.setAttributedTitle(title.attributed(), for: .normal)
        }
    }
}

extension HomeView: ViewConfiguration {
    func buildViewHierarchy() {
        addSubview(containerView)
        containerView.addSubview(backgroundImage)
        containerView.addSubview(logoView)
        containerView.addSubview(infoLabel)
        containerView.addSubview(highlights)
        containerView.addSubview(tutorialImage)
        containerView.addSubview(logoutButton)
        containerView.addSubview(changeLocationButton)
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
        
        logoutButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.left.right.equalTo(0).inset(20)
            make.bottom.equalTo(0).inset(20)
        }
        
        changeLocationButton.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.left.right.equalTo(0).inset(60)
            make.bottom.equalTo(tutorialImage.snp.bottom).offset(20)
        }
    }
}
