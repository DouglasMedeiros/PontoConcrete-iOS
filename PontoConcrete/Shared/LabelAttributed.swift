//
//  LabelAttributed.swift
//  PontoConcrete
//
//  Created by Douglas Medeiros on 18/11/17.
//  Copyright © 2017 Lucas Salton Cardinali. All rights reserved.
//

import SwiftyAttributes
import FontAwesome

public enum LabelAttributed {
    case custom(String)
    case address(String)
    case salutationSuccess(time: Date)
    case start
    case reloadButton
    case buttonTry
    case login
    case errorRequest
    case errorLocation
    case errorGeocodeLocation
    case errorInternet
    
    func attributed() -> NSAttributedString {
        let fontAwesome = UIFont.fontAwesome(ofSize: 24)
        switch self {
        case .address(let address):
            return "Endereço aproximado: ".withFont(.systemFont(ofSize: 11)) + address.withFont(.boldSystemFont(ofSize: 12))
        case .salutationSuccess(let time):
            return "\u{f1ae} ".withFont(fontAwesome) + time.salutation().withFont(.systemFont(ofSize: 24))
        case .start:
            return "\u{f017}".withFont(fontAwesome).withTextColor(.white) + " BATER O PONTO".withFont(.systemFont(ofSize: 24)).withTextColor(.white)
        case .reloadButton:
            return "\u{f021}".withFont(fontAwesome).withTextColor(.catalinaBlue)
        case .buttonTry:
            return "\u{f021}".withFont(fontAwesome).withTextColor(.white) + " Tentar novamente".withFont(.systemFont(ofSize: 24)).withTextColor(.white)
        case .errorLocation:
            return "Houve um problema ao tentar obter sua localização".withFont(.systemFont(ofSize: 13)).withTextColor(.black)
        case .errorRequest:
            return "\u{f071}".withFont(UIFont.fontAwesome(ofSize: 13)) + "Ops.. houve um problema no request, tente novamente".withFont(.systemFont(ofSize: 13)).withTextColor(.black)
        case .errorGeocodeLocation:
            return "\u{f071}".withFont(UIFont.fontAwesome(ofSize: 13)) + "Ops.. não foi possível encontrar um endereço com a sua posição atual, tente novamente".withFont(.systemFont(ofSize: 13)).withTextColor(.black)
        case .login:
            return "Se logue no app para poder bater o ponto!".withFont(.systemFont(ofSize: 15)).withTextColor(.black)
        case .custom(let message):
            return message.withFont(.systemFont(ofSize: 15)).withTextColor(.black)
        case .errorInternet:
            return "Verifique sua conexão com a internet!".withFont(.systemFont(ofSize: 15)).withTextColor(.black)
        }
    }
}
