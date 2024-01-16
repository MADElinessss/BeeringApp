//
//  UIViewController+Extension.swift
//  BeeringApp
//
//  Created by Madeline on 2024/01/16.
//

import UIKit

extension UIViewController {
    static var identifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell {
    static var identifier: String {
        return String(describing: self)
    }
}
