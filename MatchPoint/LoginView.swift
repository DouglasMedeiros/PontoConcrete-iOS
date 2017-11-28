//
//  LoginView.swift
//  MatchPoint
//
//  Created by Douglas Brito de Medeiros on 11/11/17.
//  Copyright © 2017 Lucas Salton Cardinali. All rights reserved.
//

import SnapKit
import JVFloatLabeledTextField
import FontAwesome_swift

class LoginView: UIView {
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
    
    lazy var emailTextField: SkyFloatingLabelTextFieldWithIcon = {
        let tf = SkyFloatingLabelTextFieldWithIcon(frame: .zero)
        tf.title = "E-mail"
        tf.textColor = .white
        tf.placeholder = "E-mail"
        tf.iconFont = UIFont.fontAwesome(ofSize: 15)
        tf.iconText = "\u{f003}"
        tf.selectedIconColor = .madison
        tf.placeholderColor = .madison
        tf.errorColor = .lust
        tf.iconColor = .madison
        tf.tintColor = .madison
        tf.textColor = .madison
        tf.lineColor = .madison
        tf.selectedTitleColor = .madison
        tf.selectedLineColor = .madison
        
        tf.tag = 99
        tf.borderStyle = .none
        tf.keyboardType = .emailAddress
        tf.returnKeyType = .next
        tf.spellCheckingType = .no
        tf.autocapitalizationType = .none
        tf.autocorrectionType = .no
        return tf
    }()
    
    lazy var passwordTextField: SkyFloatingLabelTextFieldWithIcon = {
        let tf = SkyFloatingLabelTextFieldWithIcon(frame: .zero)
        tf.title = "Senha"
        tf.textColor = .white
        tf.placeholder = "Senha"
        tf.iconFont = UIFont.fontAwesome(ofSize: 15)
        tf.iconText = "\u{f13e}"
        
        tf.errorColor = .lust
        tf.selectedIconColor = .madison
        tf.placeholderColor = .madison
        tf.iconColor = .madison
        tf.tintColor = .madison
        tf.textColor = .madison
        tf.lineColor = .madison
        tf.selectedTitleColor = .madison
        tf.selectedLineColor = .madison
        
        tf.borderStyle = .none
        tf.isSecureTextEntry = true
        tf.keyboardType = .default
        tf.returnKeyType = .go
        tf.spellCheckingType = .no
        tf.autocapitalizationType = .none
        tf.autocorrectionType = .no
        return tf
    }()
    
    lazy var incorrectLoginLabel: UILabel = {
        let lb = UILabel(frame: .zero)
        lb.font = UIFont.systemFont(ofSize: 17)
        lb.numberOfLines = 2
        lb.textColor = .white
        lb.text = "Dados Incorretos"
        return lb
    }()
    
    lazy var loginButton: UIButton = { () -> UIButton in
        let view = UIButton(frame: .zero)
        view.setTitle("", for: .disabled)
        view.setTitle("Entrar", for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.titleLabel?.font = .systemFont(ofSize: 17)
        view.borderColor = .white
        view.borderWidth = 1
        view.cornerRadius = 10
        return view
    }()
    
    lazy fileprivate(set) var activityIndicator = { () -> UIActivityIndicatorView in
        let aiv = UIActivityIndicatorView(frame: .zero)
        aiv.hidesWhenStopped = true
        aiv.activityIndicatorViewStyle = .white
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

public enum LoginUIState {
    case ready
    case error(String)
    case loading
}

extension LoginView {
    
    func updateUI(state: LoginUIState) {
        containerView.isUserInteractionEnabled = true
        activityIndicator.stopAnimating()
        loginButton.alpha = 1
        incorrectLoginLabel.text = ""
        loginButton.isEnabled = true
        
        switch state {
        case .loading:
            containerView.isUserInteractionEnabled = false
            activityIndicator.startAnimating()
            loginButton.alpha = 0.2
            incorrectLoginLabel.alpha = 1
            loginButton.isEnabled = false
        case .ready:
            incorrectLoginLabel.alpha = 0
        case .error(let error):
            incorrectLoginLabel.isHidden = false
            incorrectLoginLabel.alpha = 1
            incorrectLoginLabel.text = error
            containerView.shake()
        }
    }
}

extension LoginView: ViewConfiguration {
    func buildViewHierarchy() {
        addSubview(containerView)
        containerView.addSubview(backgroundImage)
        containerView.addSubview(logoView)
        containerView.addSubview(emailTextField)
        containerView.addSubview(passwordTextField)
        containerView.addSubview(incorrectLoginLabel)
        containerView.addSubview(activityIndicator)
        containerView.addSubview(loginButton)
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
            make.top.equalTo(80)
            make.width.equalTo(164)
            make.height.equalTo(105)
        }
        
        self.setupTextFields()
        
        activityIndicator.snp.makeConstraints { make in
            make.width.height.equalTo(20)
            make.center.equalTo(loginButton)
        }
        
        loginButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.bottom.left.right.equalTo(0).inset(20)
        }
    }
    
    private func setupTextFields() {
        emailTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(logoView.snp.bottom).offset(50)
            make.width.equalTo(310)
            make.height.equalTo(45)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(emailTextField.snp.bottom).offset(20)
            make.width.equalTo(310)
            make.height.equalTo(45)
        }
        
        incorrectLoginLabel.snp.makeConstraints { make in
            make.left.equalTo(passwordTextField.snp.left)
            make.top.equalTo(passwordTextField.snp.bottom).inset(-10)
            make.width.equalTo(276)
            make.height.equalTo(30)
        }
    }
}
