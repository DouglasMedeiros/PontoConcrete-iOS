//
//  HomeViewSpec.swift
//  MatchPointTests
//
//  Created by Douglas Medeiros on 25/11/17.
//  Copyright © 2017 Lucas Salton Cardinali. All rights reserved.
//

import Quick
import Nimble
import Nimble_Snapshots

@testable import MatchPoint

class HomeViewSpec: QuickSpec {
    override func spec() {
        
        var sut: HomeView!
        
        beforeEach {
            sut = HomeView()
        }
        
        it("should be able to create a instance of HomeView") {
            expect(sut).toNot(beNil())
        }
        
        context("layout", {
            it("should have expected layout home") {
                sut.frame = CGRect(x: 0, y: 0, width: 375, height: 667)
                expect(sut) == snapshot("HomeView-Off")
            }
            
            it("should have expected layout home - notification enabled") {
                sut.frame = CGRect(x: 0, y: 0, width: 375, height: 667)
                sut.switchControl.isOn = true
                expect(sut) == snapshot("HomeView-On")
            }
        })
    }
}
