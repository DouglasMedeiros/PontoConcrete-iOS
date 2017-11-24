//
//  PontoMaisRoute.swift
//  MatchPoint
//
//  Created by Lucas Salton Cardinali on 13/09/17.
//  Copyright © 2017 Lucas Salton Cardinali. All rights reserved.
//
import Moya

enum PontoMaisRoute {
    case login(login: String, password: String)
    case register(data: SessionData, point: PointData)
}

extension PontoMaisRoute: TargetType {
    var baseURL: URL {
        guard let url = URL(string: "https://api.pontomaisweb.com.br") else {
            fatalError("Base URL invalid")
        }
        return url
    }
    
    var path: String {
        switch self {
        case .login:
            return "/api/auth/sign_in"
        case .register:
            return "/api/time_cards/register"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .login, .register:
            return .post
        }
    }

    var task: Task {
        switch self {
        case .register(_, let point):
        
            let latitude = String(format: "%.7f", point.location.coordinate.latitude)
            let longitude = String(format: "%.7f", point.location.coordinate.longitude)
            let address = point.address
            
            return .requestParameters(parameters: ["time_card": [
                "latitude": latitude,
                "longitude": longitude,
                "address": address,
                "reference_id": "",
                "original_latitude": latitude,
                "original_longitude": longitude,
                "original_address": address,
                "location_edited": false,
                "accuracy": 30],
                "_path": "/meu_ponto/registro_de_ponto",
                "_device": [
                "cordova": "4.1.0",
                "manufacturer": "unknown",
                "model": "Chrome",
                "platform": "browser",
                "uuid": nil,
                "version": "61.0.3163.79"
            ],
            "_appVersion": "0.10.21"], encoding: JSONEncoding.default)

        case let .login(login, password):
            return .requestParameters(parameters: ["login": login, "password": password],
                                      encoding: JSONEncoding.default)
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var headers: [String: String]? {
        var customHeaders = ["Content-type": "application/json"]
        
        switch self {
        case let .register(data, _):
            customHeaders["access-token"] = data.token
            customHeaders["client"] = data.clientId
            customHeaders["uid"] = data.email
        default:
           return customHeaders 
        }
        return customHeaders
    }
}
