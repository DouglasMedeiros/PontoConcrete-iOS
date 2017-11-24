//
//  PontoMaisService.swift
//  MatchPoint
//
//  Created by Douglas Medeiros on 15/11/17.
//  Copyright © 2017 Lucas Salton Cardinali. All rights reserved.
//

import Foundation

protocol IPontoMaisService {
    func login(email: String, password: String, callback: @escaping IPontoMaisAPI.LoginCompletion)
    func register(credentials: SessionData, point: PointData, callback: @escaping IPontoMaisAPI.RegisterCompletion)
}

class PontoMaisService: NSObject {
    let api: IPontoMaisAPI
    
    init(provider: IPontoMaisAPI = PontoMaisAPI()) {
        api = provider
    }
}

extension PontoMaisService: IPontoMaisService {
    func register(credentials: SessionData, point: PointData, callback: @escaping IPontoMaisAPI.RegisterCompletion) {
        self.api.register(credentials: credentials, point: point, callback: callback)
    }
    
    func login(email: String, password: String, callback: @escaping IPontoMaisAPI.LoginCompletion) {
        self.api.login(email: email, password: password, callback: callback)
    }
}
