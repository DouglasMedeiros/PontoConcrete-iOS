//
//  PontoMaisAPI.swift
//  MatchPoint
//
//  Created by Douglas Medeiros on 15/11/17.
//  Copyright © 2017 Lucas Salton Cardinali. All rights reserved.
//

import Foundation
import Moya
import Result

protocol IPontoMaisAPI {
    typealias LoginCompletion = (_ response: LoginResponse?, _ result: Result<Moya.Response, MoyaError>) -> Void
    typealias RegisterCompletion = (_ response: RegisterResponse?, _ result: Result<Moya.Response, MoyaError>) -> Void
    
    func login(email: String, password: String, callback: @escaping LoginCompletion)
    func register(credentials: SessionData, point: PointData, callback: @escaping RegisterCompletion)
}

class PontoMaisAPI: NSObject {
    let provider: MoyaProvider<PontoMaisRoute>
    
    init(provider: MoyaProvider<PontoMaisRoute> = MoyaProvider<PontoMaisRoute>()) {
        self.provider = provider
    }
}

extension PontoMaisAPI: IPontoMaisAPI {
    
    public func convertResponseToResult(_ response: HTTPURLResponse?, request: URLRequest?, data: Data?, error: Swift.Error?) ->
        Result<Moya.Response, MoyaError> {
            switch (response, data, error) {
            case let (.some(response), data, .none):
                let response = Moya.Response(statusCode: response.statusCode, data: data ?? Data(), request: request, response: response)
                return .success(response)
            case let (.some(response), _, .some(error)):
                let response = Moya.Response(statusCode: response.statusCode, data: data ?? Data(), request: request, response: response)
                let error = MoyaError.underlying(error, response)
                return .failure(error)
            case let (_, _, .some(error)):
                let error = MoyaError.underlying(error, nil)
                return .failure(error)
            default:
                let error = MoyaError.underlying(NSError(domain: NSURLErrorDomain, code: NSURLErrorUnknown, userInfo: nil), nil)
                return .failure(error)
            }
    }
    
    func register(credentials: SessionData, point: PointData, callback: @escaping IPontoMaisAPI.RegisterCompletion) {
        self.provider.request(.register(data: credentials, point: point)) { result in
            switch result {
            case let .success(response):
                guard let responseString = String(data: response.data, encoding: String.Encoding.utf8) else {
                    return callback(nil, result)
                }
                let register = RegisterResponse(jsonString: responseString)
                callback(register, result)
            case .failure:
                callback(nil, result)
            }
        }
    }
    
    func login(email: String, password: String, callback: @escaping IPontoMaisAPI.LoginCompletion) {
        provider.request(.login(login: email, password: password)) { result in
            switch result {
            case let .success(response):

                guard let responseString = String(data: response.data, encoding: String.Encoding.utf8) else {
                    return callback(nil, result)
                }
                let login = LoginResponse(jsonString: responseString)
                callback(login, result)
            case .failure:
                callback(nil, result)
            }
        }
    }
}
