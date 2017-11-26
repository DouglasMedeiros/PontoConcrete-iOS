//
//  RootViewControllerProvider.swift
//  MatchPoint
//
//  Created by Douglas Brito de Medeiros on 11/11/17.
//  Copyright © 2017 Lucas Salton Cardinali. All rights reserved.
//

import UIKit

public protocol RootViewControllerProvider: class {
    var rootViewController: UIViewController { get }
}

public typealias RootViewCoordinator = RootViewControllerProvider
