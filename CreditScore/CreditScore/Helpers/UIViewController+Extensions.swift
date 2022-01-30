//
//  UIViewController+Extensions.swift
//  CreditScore
//
//  Created by Vivek Jayakumar on 30/1/22.
//

import UIKit

extension UIViewController {
    static func loadFromNib() -> Self {
        func instantiateFromNib<T: UIViewController>() -> T {
            return T.init(nibName: String(describing: T.self), bundle: nil)
        }

        return instantiateFromNib()
    }
}
