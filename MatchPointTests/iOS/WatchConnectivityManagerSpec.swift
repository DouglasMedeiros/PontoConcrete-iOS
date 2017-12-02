//
//  WatchConnectivityManagerSpec.swift
//  MatchPointTests
//
//  Created by Douglas Medeiros on 02/12/17.
//  Copyright © 2017 Lucas Salton Cardinali. All rights reserved.
//

import Quick
import Nimble
import SwiftWatchConnectivity

@testable import MatchPoint

class WatchConnectivityManagerSpec: QuickSpec {
    override func spec() {
        
        var sut: WatchConnectivityManager!
        
        beforeEach {
            sut = WatchConnectivityManager()
        }
        
        it("should be able to create a instance of WatchConnectivityManager") {
            expect(sut).toNot(beNil())
        }
        
        it("should be able to create a instance of Delegate") {
            sut.start()
            expect(sut.watchConnectivity.delegate?.isKind(of: WatchConnectivityManager.self)).to(beTrue())
        }
    }
}

