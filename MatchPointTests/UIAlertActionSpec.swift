//
//  UIAlertActionSpec.swift
//  MatchPointTests
//
//  Created by Douglas Medeiros on 26/11/17.
//  Copyright © 2017 Lucas Salton Cardinali. All rights reserved.
//

import Quick
import Nimble

@testable import MatchPoint

class UIAlertSpec: QuickSpec {
    
    override func spec() {
        var sut: UIAlertAction!
        
        describe("UIAlertAction") {
            context("when creating") {
                
                beforeEach {
                    sut = UIAlertAction.createUIAlertAction(title: "Title", style: UIAlertActionStyle.destructive, handler: nil)
                }
                
                it("instance") {
                    expect(sut.title).to(equal("Title"))
                    expect(sut.style).to(equal(UIAlertActionStyle.destructive))
                    expect(sut.isEnabled).to(beTrue())
                }
            }
        }
    }
}
