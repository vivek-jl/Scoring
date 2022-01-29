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
        guard let creditScoreViewController = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "CreditScoreView") as? CreditScoreViewController else {
            fatalError("Unable to Instantiate CreditScoreViewController")
        }
        navigationController.pushViewController(creditScoreViewController, animated: true)
    }
}
