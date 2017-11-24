//
//  ViewController.swift
//  MatchPoint
//
//  Created by Lucas Salton Cardinali on 13/09/17.
//  Copyright © 2017 Lucas Salton Cardinali. All rights reserved.
//

import UIKit
import SwiftWatchConnectivity

fileprivate extension Selector {
    static let loginTapped = #selector(LoginViewController.tappedLogin)
}

protocol LoginViewControllerDelegate: class {
    func loginViewControllerDidTapAutenticate(viewController: LoginViewController)
}

class LoginViewController: UIViewController {
    
    weak var delegate: LoginViewControllerDelegate?
    
    let containerView = LoginView()
    let service: PontoMaisService
    
    init(service: PontoMaisService = PontoMaisService()) {
        self.service = service
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        view = containerView
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text {
            if let floatingLabelTextField = textField as? SkyFloatingLabelTextField, floatingLabelTextField.tag == 99 {
                if text.count < 3 || !text.contains("@") {
                    floatingLabelTextField.errorMessage = "E-mail inválido"
                } else {
                    floatingLabelTextField.errorMessage = ""
                }
            }
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == self.containerView.emailTextField {
            containerView.passwordTextField.becomeFirstResponder()
            return true
        }
        
        textField.resignFirstResponder()
        
        if containerView.emailTextField.text != "" && containerView.passwordTextField.text != "" {
            login()
        }
        
        return true
    }
}

extension LoginViewController {
    
    private func setupView() {
        containerView.updateUI(state: .ready)
        
        containerView.loginButton.addTarget(self, action: .loginTapped, for: .touchUpInside)
        containerView.emailTextField.delegate = self
        containerView.passwordTextField.delegate = self
    }
    
    @objc
    fileprivate func tappedLogin() {
        self.login()
    }
    
    private func showLoginError() {
        containerView.updateUI(state: .error("Dados Incorretos"))
    }
    
    private func login() {
        containerView.updateUI(state: .loading)
        
        guard let login = self.containerView.emailTextField.text,
            let password = self.containerView.passwordTextField.text else {
                return
        }
        
        self.service.login(email: login, password: password) { (loginResponse, result) in
            switch result {
            case .success:
                if let validLogin = loginResponse {
                    
                    guard let token = validLogin.token, let clientId = validLogin.clientId else {
                        self.showLoginError()
                        return
                    }
                    
                    guard let email = self.containerView.emailTextField.text else { return }
                    
                    let user = SessionData(token: token, clientId: clientId, email: email)
                    
                    guard CurrentUser.shared.new(user: user) else { return }
                    
                    SwiftWatchConnectivity.shared.sendMesssage(message: user.asDict())
                    
                    self.delegate?.loginViewControllerDidTapAutenticate(viewController: self)
                }
                
            case .failure(let error):
                self.containerView.updateUI(state: .error(error.localizedDescription))
            }
        }
    }
}
