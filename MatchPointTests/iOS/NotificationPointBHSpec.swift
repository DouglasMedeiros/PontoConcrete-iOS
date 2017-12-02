//
//  NotificationPointBHSpec.swift
//  MatchPointTests
//
//  Created by Douglas Medeiros on 25/11/17.
//  Copyright © 2017 Lucas Salton Cardinali. All rights reserved.
//

import Quick
import Nimble

@testable import MatchPoint

class NotificationPointBHSpec: QuickSpec {
    override func spec() {
        
        var sut: NotificationPointBH!
        
        beforeEach {
            sut = NotificationPointBH(content: NotificationDefaultContent())
        }
        
        it("should be able to create a instance of NotificationPointBH") {
            expect(sut).toNot(beNil())
        }
        
        it("should be able to read params") {
            expect(sut.name).to(equal("ConcreteBH"))
            expect(sut.point.latitude).to(equal(-19.935331))
            expect(sut.point.longitude).to(equal(-43.929717))
        }
        
        it("should be able to build UNNotificationRequest") {
            let request = sut.request()
            expect(request.identifier).to(equal("ConcreteBH"))
        }
    }
}

