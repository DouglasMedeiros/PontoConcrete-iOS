//
//  DateSpec.swift
//  PontoConcreteTests
//
//  Created by Douglas Medeiros on 25/11/17.
//  Copyright © 2017 Lucas Salton Cardinali. All rights reserved.
//

import Quick
import Nimble

@testable import PontoConcrete

class DateSpec: QuickSpec {
    
    private func createDateTime(hour: Int) -> Date {
        var userCalendar = Calendar.current
        userCalendar.locale = Locale(identifier: "pt_BR")
        userCalendar.timeZone = TimeZone(identifier: "America/Sao_Paulo")!
        
        var components = DateComponents()
        components.year = 2017
        components.weekOfYear = 18
        components.weekday = 5
        components.minute = 10
        components.hour = hour
        components.timeZone = TimeZone(identifier: "America/Sao_Paulo")!
        
        return userCalendar.date(from: components)!
    }
    
    override func spec() {
        var sut: Date!
        
        it("should be able display `bom trabalho`") {
            sut = self.createDateTime(hour: 9)
            expect(sut.salutation()).to(equal("Bom Trabalho!".uppercased()))
        }
        
        it("should be able display `bom almoço`") {
            sut = self.createDateTime(hour: 12)
            expect(sut.salutation()).to(equal("Bom almoço!".uppercased()))
        }
        
        it("should be able display `bom trabalho`") {
            sut = self.createDateTime(hour: 15)
            expect(sut.salutation()).to(equal("Bom trabalho!".uppercased()))
        }
        
        it("should be able display `boa volta`") {
            sut = self.createDateTime(hour: 18)
            expect(sut.salutation()).to(equal("Boa volta!".uppercased()))
        }
    }
}
