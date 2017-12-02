//
//  NotificationPointRJSpec.swift
//  MatchPointTests
//
//  Created by Douglas Medeiros on 25/11/17.
//  Copyright © 2017 Lucas Salton Cardinali. All rights reserved.
//

import Quick
import Nimble

@testable import MatchPoint

class NotificationPointRJSpec: QuickSpec {
    override func spec() {
        
        var sut: NotificationPointRJ!
        
        beforeEach {
            sut = NotificationPointRJ(content: NotificationDefaultContent())
        }
        
        it("should be able to create a instance of NotificationPointRJ") {
            expect(sut).toNot(beNil())
        }
        
        it("should be able to read params") {
            expect(sut.name).to(equal("ConcreteRJ"))
            expect(sut.point.latitude).to(equal(-22.910222))
            expect(sut.point.longitude).to(equal(-43.172658))
        }
        
        it("should be able to build UNNotificationRequest") {
            let request = sut.request()
            expect(request.identifier).to(equal("ConcreteRJ"))
        }
    }
}

