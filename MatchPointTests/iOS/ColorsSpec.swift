//
//  ColorsSpec.swift
//  MatchPointTests
//
//  Created by Douglas Medeiros on 25/11/17.
//  Copyright © 2017 Lucas Salton Cardinali. All rights reserved.
//

import Quick
import Nimble
import Nimble_Snapshots

@testable import MatchPoint

class ColorsSpec: QuickSpec {
    override func spec() {
        
        var sut: UIColor!
        
        var view: UIView!
        
        beforeEach {
            view = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 100))
        }
        
        context("colors", {
            it("should have expected color `Catalina Blue`") {
                sut = .catalinaBlue
                
                let expected = UIColor(hue: 0.64, saturation: 0.88, brightness: 0.50, alpha: 1.00)
                expect(sut.cgColor).to(equal(expected.cgColor))
                
                view.backgroundColor = sut
                
                expect(view) == snapshot("Color-CatalinaBlue")
            }
            
            it("should have expected color `text` (black)") {
                sut = .text
                let expected = UIColor.black
                expect(sut.cgColor).to(equal(expected.cgColor))
                
                view.backgroundColor = sut
                expect(view) == snapshot("Color-Text")
            }
            
            it("should have expected color `successColor` (green)") {
                sut = .successColor
                let expected = UIColor(red: 0.32, green: 0.48, blue: 0.93, alpha: 1.0)
                expect(sut.cgColor).to(equal(expected.cgColor))
                
                view.backgroundColor = sut
                expect(view) == snapshot("Color-Success")
            }
            
            it("should have expected color `error` (red)") {
                sut = .error
                let expected = UIColor(red: 0.65, green: 0.00, blue: 0.00, alpha: 1.0)
                expect(sut.cgColor).to(equal(expected.cgColor))
                
                view.backgroundColor = sut
                expect(view) == snapshot("Color-Error")
            }
        })
    }
}


