//
//  UIButtonSpec.swift
//  MatchPointTests
//
//  Created by Douglas Medeiros on 25/11/17.
//  Copyright © 2017 Lucas Salton Cardinali. All rights reserved.
//

import Quick
import Nimble

@testable import MatchPoint

class UIButtonSpec: QuickSpec {
    override func spec() {
        
        var sut: UIButton!
        
        beforeEach {
            sut = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 80))
        }
        
        it("should be able to create a instance of UIButtons") {
            expect(sut).toNot(beNil())
        }
        
        it("should be able to read params") {
            sut.borderWidth = 3
            sut.borderColor = .red
            sut.cornerRadius = 10
            
            expect(sut.borderWidth).to(equal(3))
            expect(sut.borderColor?.cgColor).to(equal(UIColor.red.cgColor))
            expect(sut.cornerRadius).to(equal(10))
        }
    }
}

