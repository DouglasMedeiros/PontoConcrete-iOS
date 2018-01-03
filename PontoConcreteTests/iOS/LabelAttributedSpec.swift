//
//  LabelAttributedSpec.swift
//  PontoConcreteTests
//
//  Created by Douglas Medeiros on 26/11/17.
//  Copyright © 2017 Lucas Salton Cardinali. All rights reserved.
//

import Quick
import Nimble

@testable import PontoConcrete

class LabelAttributedSpec: QuickSpec {
    override func spec() {
        it("try") {
            expect(LabelAttributed.buttonTry.attributed().string).to(equal("\u{f021} Tentar novamente"))
        }
        
        it("address `Fagundes Dias, 221`") {
            let address = "Fagundes Dias, 221"
            expect(LabelAttributed.address(address).attributed().string).to(equal("Endereço aproximado: Fagundes Dias, 221"))
        }
        
        it("start") {
            expect(LabelAttributed.start.attributed().string).to(equal("\u{f017} BATER O PONTO"))
        }
        
        it("errorRequest") {
            expect(LabelAttributed.errorRequest.attributed().string).to(equal("\u{f071}Ops.. houve um problema no request, tente novamente"))
        }
        
        it("login") {
            expect(LabelAttributed.login.attributed().string).to(equal("Se logue no app para poder bater o ponto!"))
        }
        
        it("errorInternet") {
            expect(LabelAttributed.errorInternet.attributed().string).to(equal("Verifique sua conexão com a internet!"))
        }
        
        it("reload") {
            expect(LabelAttributed.reloadButton.attributed().string).to(equal("\u{f021}"))
        }
        
        it("custom") {
            expect(LabelAttributed.custom("Teste").attributed().string).to(equal("Teste"))
        }
        
        it("salutationSuccess") {
            
            let userCalendar = Calendar.current
            
            var components = DateComponents()
            components.year = 2017
            components.weekOfYear = 18
            components.weekday = 5
            components.minute = 10
            components.hour = 9
            components.timeZone = TimeZone(identifier: "America/Sao_Paulo")!
            
            let date = userCalendar.date(from: components)!
            
            expect(LabelAttributed.salutationSuccess(time: date).attributed().string).to(equal("\u{f1ae} BOM TRABALHO!"))
        }

    }
}
