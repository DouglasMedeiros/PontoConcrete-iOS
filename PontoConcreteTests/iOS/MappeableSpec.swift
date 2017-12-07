//
//  MappeableSpec.swift
//  PontoConcreteTests
//
//  Created by Douglas Medeiros on 25/11/17.
//  Copyright © 2017 Lucas Salton Cardinali. All rights reserved.
//

import Quick
import Nimble

@testable import PontoConcrete

class MappableSample: Mappable {
    let name: String?
    let enabled: Bool
    let quantity: Int?
    
    private enum CodingKeys: String, CodingKey {
        case name = "name"
        case enabled = "enabled"
        case quantity = "quantityTotal"
    }
}

class MappeableSpec: QuickSpec {
    
    override func spec() {
        
        var sut: MappableSample!
        
        it("should be able to create a instance") {
            sut = MappableSample(jsonString: "{\"name\":\"Name 1\",\"enabled\":true,\"quantityTotal\":100}")
            expect(sut.name).to(equal("Name 1"))
            expect(sut.enabled).to(beTrue())
            expect(sut.quantity).to(equal(100))
        }
        
        it("not should be able to create a instance") {
            sut = MappableSample(jsonString: "")
            expect(sut).to(beNil())
        }
    }
}


