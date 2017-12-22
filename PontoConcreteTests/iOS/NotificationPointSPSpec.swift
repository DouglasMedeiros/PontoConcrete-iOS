//
//  NotificationPointSPSpec.swift
//  PontoConcreteTests
//
//  Created by Douglas Medeiros on 25/11/17.
//  Copyright © 2017 Lucas Salton Cardinali. All rights reserved.
//

import Quick
import Nimble

@testable import PontoConcrete

class NotificationPointSPSpec: QuickSpec {
    override func spec() {
        
        var sut: NotificationPointSP!
        
        beforeEach {
            sut = NotificationPointSP(content: NotificationDefaultContent())
        }
        
        it("should be able to create a instance of NotificationPointSP") {
            expect(sut).toNot(beNil())
        }
        
        it("should be able to read params") {
            expect(sut.name).to(equal("ConcreteSP"))
            expect(sut.point.point().location.coordinate.latitude).to(equal(-23.601449))
            expect(sut.point.point().location.coordinate.longitude).to(equal(-46.694799))
        }
        
        it("should be able to build UNNotificationRequest") {
            let request = sut.request()
            expect(request.identifier).to(equal("ConcreteSP"))
        }
    }
}
