//
//  PontoConcreteUITests.swift
//  PontoConcreteUITests
//
//  Created by Douglas Medeiros on 28/11/17.
//  Copyright © 2017 Lucas Salton Cardinali. All rights reserved.
//

import XCTest

class PontoConcreteUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments.append("isUITesting")
        app.launch()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testLoginError() {
        let emailTextField = app/*@START_MENU_TOKEN@*/.textFields["email"]/*[[".textFields[\"E-mail\"]",".textFields[\"email\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        emailTextField.tap()
        emailTextField.typeText("test")
        
        app.otherElements["logotipo"].tap()
        app.buttons["entrar"].tap()
        
        let label = app.staticTexts["validator"]

        XCTAssertTrue(label.exists)
    }
    
    func testLoginErrorServer() {
        let emailTextField = app/*@START_MENU_TOKEN@*/.textFields["email"]/*[[".textFields[\"E-mail\"]",".textFields[\"email\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        emailTextField.tap()
        emailTextField.typeText("test")
        
        let senhaSecureTextField = app/*@START_MENU_TOKEN@*/.secureTextFields["senha"]/*[[".secureTextFields[\"Senha\"]",".secureTextFields[\"senha\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        senhaSecureTextField.tap()
        senhaSecureTextField.typeText("123123")
        
        app.otherElements["logotipo"].tap()
        app.buttons["entrar"].tap()
        
        let label = app.staticTexts["validator"]
        
        XCTAssertTrue(label.exists)
    }
    
    func testLoginSuccess() {
        
        let email = "email@concrete.com.br"
        let password = "123456"
        
        let emailTextField = app/*@START_MENU_TOKEN@*/.textFields["email"]/*[[".textFields[\"E-mail\"]",".textFields[\"email\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        emailTextField.tap()
        emailTextField.typeText(email)
        
        let senhaSecureTextField = app/*@START_MENU_TOKEN@*/.secureTextFields["senha"]/*[[".secureTextFields[\"Senha\"]",".secureTextFields[\"senha\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        senhaSecureTextField.tap()
        senhaSecureTextField.typeText(password)
        
        app.otherElements["logotipo"].tap()
        app.buttons["entrar"].tap()
        
        let label = app.buttons["sair"]
        
        self.waitForElementToAppear(label)
    }
    
    func testLoginFail() {
        
        let email = "emailError@concrete.com.br"
        let password = "123"
        
        let emailTextField = app/*@START_MENU_TOKEN@*/.textFields["email"]/*[[".textFields[\"E-mail\"]",".textFields[\"email\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        emailTextField.tap()
        emailTextField.typeText(email)
        
        let senhaSecureTextField = app/*@START_MENU_TOKEN@*/.secureTextFields["senha"]/*[[".secureTextFields[\"Senha\"]",".secureTextFields[\"senha\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        senhaSecureTextField.tap()
        senhaSecureTextField.typeText(password)
        
        app.otherElements["logotipo"].tap()
        app.buttons["entrar"].tap()
        
        let label = app.staticTexts["validator"]
        
        self.waitForElementToAppear(label)
    }
}

extension PontoConcreteUITests {
    @discardableResult
    func waitForElementToAppear(_ element: XCUIElement) -> Bool {
        let predicate = NSPredicate(format: "exists == true")
        let expectation = XCTNSPredicateExpectation(predicate: predicate,
                                                    object: element)
        
        let result = XCTWaiter().wait(for: [expectation], timeout: 15)
        return result == .completed
    }
}
