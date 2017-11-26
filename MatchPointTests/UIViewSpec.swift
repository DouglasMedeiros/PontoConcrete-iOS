//
//  UIViewSpec.swift
//  MatchPointTests
//
//  Created by Douglas Medeiros on 25/11/17.
//  Copyright © 2017 Lucas Salton Cardinali. All rights reserved.
//

import Quick
import Nimble

@testable import MatchPoint

class UIViewSpec: QuickSpec {
    override func spec() {
        
        var sut: UIView!
        
        it("should be able to create a instance of UIView") {
            sut = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
            expect(sut).toNot(beNil())
        }
        
        it("should be able to shake") {
            sut.shake()
            guard let animationKeys = sut.layer.animationKeys() else {
                fatalError()
            }
            
            expect(animationKeys.count).to(equal(1))
        }
    }
}
