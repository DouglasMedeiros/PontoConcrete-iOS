//
//  UIAlertAction.swift
//  MatchPoint
//
//  Created by Douglas Medeiros on 26/11/17.
//  Copyright © 2017 Lucas Salton Cardinali. All rights reserved.
//

import UIKit

extension UIAlertAction {
    @objc
    class func createUIAlertAction(title: String?, style: UIAlertActionStyle, handler: ((UIAlertAction) -> Void)?) -> UIAlertAction {
        return UIAlertAction(title: title, style: style, handler: handler)
    }
}
