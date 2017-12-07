//
//  GoogleGeocodeRoute.swift
//  PontoConcrete
//
//  Created by Douglas Medeiros on 27/11/17.
//  Copyright © 2017 Lucas Salton Cardinali. All rights reserved.
//

import Moya
import CoreLocation

enum GoogleGeocodeRoute {
    case geocode(coordinate: CLLocationCoordinate2D)
}

extension GoogleGeocodeRoute: TargetType {
    var baseURL: URL {
        guard let url = URL(string: "https://maps.googleapis.com") else {
            fatalError("Base URL invalid")
        }
        return url
    }
    
    var path: String {
        switch self {
        case .geocode:
            return "maps/api/geocode/json"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .geocode:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .geocode(let coordinate):
            let latitude = String(format: "%.7f", coordinate.latitude)
            let longitude = String(format: "%.7f", coordinate.longitude)
            return .requestParameters(parameters: [
                "latlng": "\(latitude),\(longitude)",
                "key": Constants.Google.apiKey
                ], encoding: URLEncoding.default)
        }
    }
    
    var sampleData: Data {
        
        var json = ""
        
        switch self {
        case .geocode:
            json = "{\"results\":[{\"address_components\":[{\"long_name\":\"Junipero Serra Freeway\",\"short_name\":\"I-280\",\"types\":[\"route\"]},{\"long_name\":\"San Mateo County\",\"short_name\":\"San Mateo County\",\"types\":[\"administrative_area_level_2\",\"political\"]},{\"long_name\":\"California\",\"short_name\":\"CA\",\"types\":[\"administrative_area_level_1\",\"political\"]},{\"long_name\":\"United States\",\"short_name\":\"US\",\"types\":[\"country\",\"political\"]}],\"formatted_address\":\"Junipero Serra Fwy, California, USA\",\"geometry\":{\"bounds\":{\"northeast\":{\"lat\":37.4198674,\"lng\":-122.2153469},\"southwest\":{\"lat\":37.4184889,\"lng\":-122.2219881}},\"location\":{\"lat\":37.4190201,\"lng\":-122.2187293},\"location_type\":\"GEOMETRIC_CENTER\",\"viewport\":{\"northeast\":{\"lat\":37.4205271302915,\"lng\":-122.2153469},\"southwest\":{\"lat\":37.4178291697085,\"lng\":-122.2219881}}},\"place_id\":\"ChIJxa9ak_ikj4AR1C7jZOOUHpY\",\"types\":[\"route\"]},{\"address_components\":[{\"long_name\":\"94028\",\"short_name\":\"94028\",\"types\":[\"postal_code\"]},{\"long_name\":\"Portola Valley\",\"short_name\":\"Portola Valley\",\"types\":[\"locality\",\"political\"]},{\"long_name\":\"California\",\"short_name\":\"CA\",\"types\":[\"administrative_area_level_1\",\"political\"]},{\"long_name\":\"United States\",\"short_name\":\"US\",\"types\":[\"country\",\"political\"]}],\"formatted_address\":\"Portola Valley, CA 94028, USA\",\"geometry\":{\"bounds\":{\"northeast\":{\"lat\":37.4251299,\"lng\":-122.173041},\"southwest\":{\"lat\":37.3203501,\"lng\":-122.2535389}},\"location\":{\"lat\":37.3871184,\"lng\":-122.2086579},\"location_type\":\"APPROXIMATE\",\"viewport\":{\"northeast\":{\"lat\":37.4251299,\"lng\":-122.173041},\"southwest\":{\"lat\":37.3203501,\"lng\":-122.2535389}}},\"place_id\":\"ChIJtevUxoCvj4ARMZf1SGcjXYc\",\"postcode_localities\":[\"Menlo Park\",\"Portola Valley\"],\"types\":[\"postal_code\"]},{\"address_components\":[{\"long_name\":\"San Mateo County\",\"short_name\":\"San Mateo County\",\"types\":[\"administrative_area_level_2\",\"political\"]},{\"long_name\":\"California\",\"short_name\":\"CA\",\"types\":[\"administrative_area_level_1\",\"political\"]},{\"long_name\":\"United States\",\"short_name\":\"US\",\"types\":[\"country\",\"political\"]}],\"formatted_address\":\"San Mateo County, CA, USA\",\"geometry\":{\"bounds\":{\"northeast\":{\"lat\":37.7084311,\"lng\":-122.081473},\"southwest\":{\"lat\":37.0538579,\"lng\":-122.588177}},\"location\":{\"lat\":37.4337342,\"lng\":-122.4014193},\"location_type\":\"APPROXIMATE\",\"viewport\":{\"northeast\":{\"lat\":37.7084311,\"lng\":-122.081473},\"southwest\":{\"lat\":37.0538579,\"lng\":-122.588177}}},\"place_id\":\"ChIJiUYt5gF4j4AR3OQX5ii4s1c\",\"types\":[\"administrative_area_level_2\",\"political\"]},{\"address_components\":[{\"long_name\":\"San Francisco-Oakland-Fremont, CA\",\"short_name\":\"San Francisco-Oakland-Fremont, CA\",\"types\":[\"political\"]},{\"long_name\":\"California\",\"short_name\":\"CA\",\"types\":[\"administrative_area_level_1\",\"political\"]},{\"long_name\":\"United States\",\"short_name\":\"US\",\"types\":[\"country\",\"political\"]}],\"formatted_address\":\"San Francisco-Oakland-Fremont, CA, CA, USA\",\"geometry\":{\"bounds\":{\"northeast\":{\"lat\":38.320945,\"lng\":-121.4692749},\"southwest\":{\"lat\":37.1073458,\"lng\":-123.024066}},\"location\":{\"lat\":37.8043507,\"lng\":-121.8107079},\"location_type\":\"APPROXIMATE\",\"viewport\":{\"northeast\":{\"lat\":38.320945,\"lng\":-121.4692749},\"southwest\":{\"lat\":37.1073458,\"lng\":-123.024066}}},\"place_id\":\"ChIJGUN8-q6Ij4ARZ1tA_OojshE\",\"types\":[\"political\"]},{\"address_components\":[{\"long_name\":\"San Francisco Metropolitan Area\",\"short_name\":\"San Francisco Metropolitan Area\",\"types\":[\"political\"]},{\"long_name\":\"California\",\"short_name\":\"CA\",\"types\":[\"administrative_area_level_1\",\"political\"]},{\"long_name\":\"United States\",\"short_name\":\"US\",\"types\":[\"country\",\"political\"]}],\"formatted_address\":\"San Francisco Metropolitan Area, CA, USA\",\"geometry\":{\"bounds\":{\"northeast\":{\"lat\":38.320945,\"lng\":-121.4692139},\"southwest\":{\"lat\":37.0538579,\"lng\":-123.173825}},\"location\":{\"lat\":37.7749274,\"lng\":-122.4194254},\"location_type\":\"APPROXIMATE\",\"viewport\":{\"northeast\":{\"lat\":38.320945,\"lng\":-121.4692139},\"southwest\":{\"lat\":37.0538579,\"lng\":-123.173825}}},\"place_id\":\"ChIJE156BviCj4ARKrqKa5lkEu4\",\"types\":[\"political\"]},{\"address_components\":[{\"long_name\":\"California\",\"short_name\":\"CA\",\"types\":[\"administrative_area_level_1\",\"political\"]},{\"long_name\":\"United States\",\"short_name\":\"US\",\"types\":[\"country\",\"political\"]}],\"formatted_address\":\"California, USA\",\"geometry\":{\"bounds\":{\"northeast\":{\"lat\":42.0095169,\"lng\":-114.131211},\"southwest\":{\"lat\":32.528832,\"lng\":-124.482003}},\"location\":{\"lat\":36.778261,\"lng\":-119.4179324},\"location_type\":\"APPROXIMATE\",\"viewport\":{\"northeast\":{\"lat\":42.0095169,\"lng\":-114.131211},\"southwest\":{\"lat\":32.528832,\"lng\":-124.482003}}},\"place_id\":\"ChIJPV4oX_65j4ARVW8IJ6IJUYs\",\"types\":[\"administrative_area_level_1\",\"political\"]},{\"address_components\":[{\"long_name\":\"United States\",\"short_name\":\"US\",\"types\":[\"country\",\"political\"]}],\"formatted_address\":\"United States\",\"geometry\":{\"bounds\":{\"northeast\":{\"lat\":71.5388001,\"lng\":-66.885417},\"southwest\":{\"lat\":18.7763,\"lng\":170.5957}},\"location\":{\"lat\":37.09024,\"lng\":-95.712891},\"location_type\":\"APPROXIMATE\",\"viewport\":{\"northeast\":{\"lat\":49.38,\"lng\":-66.94},\"southwest\":{\"lat\":25.82,\"lng\":-124.39}}},\"place_id\":\"ChIJCzYy5IS16lQRQrfeQ5K5Oxw\",\"types\":[\"country\",\"political\"]}],\"status\":\"OK\"}"
        }
        
        guard let data = json.data(using: .utf8) else {
            fatalError("Error sample data JSON")
        }
        return data
    }
    
    var headers: [String: String]? {
        let customHeaders = ["Content-type": "application/json"]
        return customHeaders
    }
}
