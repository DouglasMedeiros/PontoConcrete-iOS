//
//  ViewController.swift
//  MatchPoint
//
//  Created by Lucas Salton Cardinali on 13/09/17.
//  Copyright © 2017 Lucas Salton Cardinali. All rights reserved.
//

import UIKit
import Moya
import KeychainSwift
import Foundation

class SetupViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginContainer: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var incorrectLoginLabel: UILabel!
  
    let provider = MoyaProvider<PontoMaisService>()
    let keychain = KeychainSwift()

    func showLoginError() {
        self.incorrectLoginLabel.alpha = 0
        UIView.animate(withDuration: 0.5, animations: {
            self.incorrectLoginLabel.isHidden = false
            self.incorrectLoginLabel.alpha = 1
            self.activityIndicator.stopAnimating()
            self.loginButton.isEnabled = true
            self.loginButton.alpha = 1.0
        })
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.incorrectLoginLabel.alpha = 0
        loginTextField.delegate = self
        passwordTextField.delegate = self

        loginButton.setTitle("", for: .disabled)
    }

    @IBAction func didTapLoginButton(_ sender: Any) {
        login()
    }

    func login() {
        activityIndicator.startAnimating()
        loginButton.isEnabled = false
        loginButton.alpha = 0.5

        provider.request(.login(login: self.loginTextField.text!, password: self.passwordTextField.text!)) { result in
            switch result {
            case let .success(response):

                do {
                    let login = try JSONDecoder().decode(LoginResponse.self, from: response.data)

                        guard let _ = login.token, let _ = login.clientId else {
                            self.showLoginError()
                            return
                        }

                        self.keychain.set(login.token!, forKey: "token", withAccess: .accessibleAfterFirstUnlock)
                        self.keychain.set(login.clientId!, forKey: "clientId", withAccess: .accessibleAfterFirstUnlock)
                        self.keychain.set(self.loginTextField.text!, forKey: "email", withAccess: .accessibleAfterFirstUnlock)

                        self.performSegue(withIdentifier: "loggedin", sender: self)
                } catch {
                    print(error) //TODO handle decoding erros
                }
            case .failure(_):
                self.showLoginError()
            }
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if loginTextField.text != "" && passwordTextField.text != "" {
            login()
        }
        return true
    }
}
