//
//  AppCoordinator.swift
//  CreditScore
//
//  Created by Vivek Jayakumar on 29/1/22.
//

import Foundation
import UIKit

class AppCoordinator {
    
    private let navigationController = UINavigationController()
    
    var rootViewController: UIViewController {
        return navigationController
    }

    func start() {
        showScoreView()
    }

}

extension AppCoordinator {
    private func showScoreView() {
        let creditScoreViewController = CreditScoreViewController.loadFromNib()
        navigationController.pushViewController(creditScoreViewController,
                                                animated: true)
    }
}


extension UIViewController {
    static func loadFromNib() -> Self {
        func instantiateFromNib<T: UIViewController>() -> T {
            return T.init(nibName: String(describing: T.self), bundle: nil)
        }

        return instantiateFromNib()
    }
}
