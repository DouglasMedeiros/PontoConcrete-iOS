//
//  FontsSpec.swift
//  MatchPointTests
//
//  Created by Douglas Medeiros on 25/11/17.
//  Copyright © 2017 Lucas Salton Cardinali. All rights reserved.
//

import Quick
import Nimble
import Nimble_Snapshots

@testable import MatchPoint

class FontsSpec: QuickSpec {
    override func spec() {
        
        var sut: UIFont!
        
        var view: UIView!
        var label: UILabel!
        
        beforeEach {
            label = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 100))
            view = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 100))
            view.addSubview(label)
        }
        
        context("fonts", {
            it("should have expected font `Avenir-Book`") {
                sut = .avenirBook
                
                expect(sut.fontName).to(equal("Avenir-Book"))
                
                label.font = sut
                
                label.text = "Avenir-Book"
                label.textAlignment = .center
                expect(view) == snapshot("Font-Avenir-Book")
            }
            
            it("should have expected font `Avenir-Heavy`") {
                sut = .avenirHeavy
                
                expect(sut.fontName).to(equal("Avenir-Heavy"))
                
                label.font = sut
                
                label.text = "Avenir-Heavy"
                label.textAlignment = .center
                expect(view) == snapshot("Font-Avenir-Heavy")
            }
            
        })
    }
}



