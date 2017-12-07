//
//  NotificationPointFactorySpec.swift
//  PontoConcreteTests
//
//  Created by Douglas Medeiros on 25/11/17.
//  Copyright © 2017 Lucas Salton Cardinali. All rights reserved.
//

import Quick
import Nimble

@testable import PontoConcrete

class NotificationPointFactorySpec: QuickSpec {
    override func spec() {
        
        var sut: NotificationPoint!
        
        describe("Make") {
            
            context("successfull login") {
                
                afterEach {
                    sut = nil
                }
                
                it("sp") {
                    sut = NotificationPointFactory.notification(for: Point.saoPaulo)
                    expect(sut.name).to(equal("ConcreteSP"))
                }
                
                it("rj") {
                    sut = NotificationPointFactory.notification(for: Point.rioDeJaneiro)
                    expect(sut.name).to(equal("ConcreteRJ"))
                }
                
                it("mg") {
                    sut = NotificationPointFactory.notification(for: Point.minasGerais)
                    expect(sut.name).to(equal("ConcreteBH"))
                }
            }
        }
    }
}
