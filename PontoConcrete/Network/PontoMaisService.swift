//
//  PontoMaisService.swift
//  PontoConcrete
//
//  Created by Douglas Medeiros on 15/11/17.
//  Copyright © 2017 Lucas Salton Cardinali. All rights reserved.
//

import Foundation
import Moya

protocol IPontoMaisService: class {
    func login(email: String, password: String, callback: @escaping IPontoMaisAPI.LoginCompletion) -> Cancellable
    func register(credentials: SessionData, point: PointData, callback: @escaping IPontoMaisAPI.RegisterCompletion) -> Cancellable
}

class PontoMaisService {
    let api: IPontoMaisAPI
    
    init(provider: IPontoMaisAPI = PontoMaisAPI()) {
        api = provider
    }
}

extension PontoMaisService: IPontoMaisService {
    @discardableResult
    func register(credentials: SessionData, point: PointData, callback: @escaping IPontoMaisAPI.RegisterCompletion) -> Cancellable {
        return self.api.register(credentials: credentials, point: point, callback: callback)
    }
    
    @discardableResult
    func login(email: String, password: String, callback: @escaping IPontoMaisAPI.LoginCompletion) -> Cancellable {
        return self.api.login(email: email, password: password, callback: callback)
    }
}
