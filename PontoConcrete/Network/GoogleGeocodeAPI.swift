//
//  GoogleGeocodeAPI.swift
//  PontoConcrete
//
//  Created by Douglas Medeiros on 27/11/17.
//  Copyright © 2017 Lucas Salton Cardinali. All rights reserved.
//

import Foundation
import Moya
import Result
import CoreLocation

protocol IGoogleGeocodeAPI {
    typealias GeocodeCompletion = (_ response: GeocodeResponse?, _ result: Result<Moya.Response, MoyaError>) -> Void
    
    func geocode(coordinate: CLLocationCoordinate2D, callback: @escaping GeocodeCompletion) -> Cancellable
}

class GoogleGeocodeAPI: NSObject {
    let provider: MoyaProvider<GoogleGeocodeRoute>
    
    init(provider: MoyaProvider<GoogleGeocodeRoute> = MoyaProvider<GoogleGeocodeRoute>(plugins: [NetworkLoggerPlugin(verbose: true)])) {
        self.provider = provider
    }
}

extension GoogleGeocodeAPI: IGoogleGeocodeAPI {
    @discardableResult
    func geocode(coordinate: CLLocationCoordinate2D, callback: @escaping IGoogleGeocodeAPI.GeocodeCompletion) -> Cancellable {
        return self.provider.request(.geocode(coordinate: coordinate)) { result in
            switch result {
            case let .success(response):
                do {
                    let json = try JSONSerialization.jsonObject(with: response.data, options: .allowFragments) as? [String: Any]
                    if let responseJSON = json {
                        if let status = responseJSON["status"] as? String, status == "OK" {
                            if let resultResponse = responseJSON["results"] as? [[String: Any]], let address = resultResponse[0]["formatted_address"] as? String {
                                let geocode = GeocodeResponse(address: address)
                                callback(geocode, result)
                                return
                            }
                        }
                    }
                    callback(nil, result)
                } catch let error as NSError {
                    print("error parse: \(error.localizedDescription)")
                    callback(nil, result)
                }
            case .failure:
                callback(nil, result)
            }
        }
    }
}
