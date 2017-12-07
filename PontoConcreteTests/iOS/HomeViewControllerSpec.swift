//
//  HomeViewControllerSpec.swift
//  PontoConcreteTests
//
//  Created by Douglas Medeiros on 25/11/17.
//  Copyright © 2017 Lucas Salton Cardinali. All rights reserved.
//

import Quick
import Nimble

@testable import PontoConcrete

class HomeViewControllerMock: HomeViewController {
    var viewControllerToPresent: UIViewController?
    override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        self.viewControllerToPresent = viewControllerToPresent
    }
}

class UIAlertActionMock : UIAlertAction {
    typealias Handler = ((UIAlertAction) -> Void)
    var handler: Handler?
    var titleMock: String?
    var styleMock: UIAlertActionStyle
    override init() {
        styleMock = .default
        super.init()
    }
    convenience init(title: String?, style: UIAlertActionStyle, handler: ((UIAlertAction) -> Void)?) {
        self.init()
        titleMock = title
        styleMock = style
        self.handler = handler
    }
    
    override class func createUIAlertAction(title: String?, style: UIAlertActionStyle, handler: ((UIAlertAction) -> Void)?) -> UIAlertActionMock {
        return UIAlertActionMock(title: title, style: style, handler: handler)
    }
}

class HomeViewControllerSpec: QuickSpec {
    
    override func spec() {
        var sut: HomeViewControllerMock!
        
        describe("HomeViewController") {
            context("when creating") {
                
                beforeEach {
                    sut = HomeViewControllerMock()
                    _ = sut.view
                }
                
                it("instance") {
                    expect(sut.view.isKind(of: HomeView.self)).to(beTrue())
                }
                
                it("didTapLogoutButton") {
                    sut.uiAlertAction = UIAlertActionMock.self
                    
                    sut.didTapLogoutButton()
                    
                    expect(sut.viewControllerToPresent).toNot(beNil())
                    
                    if let alertController = sut.viewControllerToPresent as? UIAlertController {
                        expect(alertController.title).to(equal("Sair"))
                        expect(alertController.message).to(equal("Tem certeza que deseja sair?"))
                        
                        let actionOK = alertController.actions[0] as! UIAlertActionMock
                        actionOK.handler!(actionOK)
                        expect(actionOK.titleMock).to(equal("Sim"))
                        
                        let actionNot = alertController.actions[1] as! UIAlertActionMock
                        actionNot.handler!(actionNot)
                        expect(actionNot.titleMock).to(equal("Não"))
                    } else {
                        fail()
                    }
                    
                    expect(sut.viewControllerToPresent).toNot(beNil())
                }
            }
        }
    }
}
