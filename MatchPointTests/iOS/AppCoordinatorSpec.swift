//
//  AppCoordinatorSpec.swift
//  MatchPointTests
//
//  Created by Douglas Medeiros on 25/11/17.
//  Copyright © 2017 Lucas Salton Cardinali. All rights reserved.
//

import Quick
import Nimble
import KeychainSwift

@testable import MatchPoint

class CurrentUserMock: CurrentUserProtocol {
    
    var start: SessionData? = SessionData(token: "123", clientId: "client123", email: "email@server.com")
    
    static let shared = CurrentUserMock()
    
    func user() -> SessionData? {
        return start
    }
    
    func isLoggedIn() -> Bool {
        return true
    }
    
    func remove() -> Bool {
        start = nil
        return true
    }
}

class AppCoordinatorSpec: QuickSpec {
    
    override func spec() {
        
        var sut: AppCoordinator!
        var window: UIWindow!
        
        beforeEach {
            window = UIWindow(frame: UIScreen.main.bounds)
            sut = AppCoordinator(window: window)
        }
        
        it("should be able to create a instance") {
            expect(sut).toNot(beNil())
        }
        
        it("should be able to create a instance") {
            
            sut.currentUser = CurrentUserMock.shared
            sut.start()
            
            guard let viewController = sut.navigationController.viewControllers.first as? HomeViewController else {
                fail()
                return
            }
            
            viewController.delegate?.homeViewControllerDidLogout(viewController: viewController)
            
            expect(viewController.isKind(of: HomeViewController.self)).to(beTrue())
        }
    }
}



