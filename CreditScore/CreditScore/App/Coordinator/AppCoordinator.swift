//
//  AppCoordinator.swift
//  CreditScore
//
//  Created by Vivek Jayakumar on 29/1/22.
//

import Foundation
import UIKit


protocol AppCoordinatorDelegate: AnyObject {
    func showCreditScoreDetails(info: CreditScoreInfo)
}

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
        creditScoreViewController.coordinatorDelegate = self
        navigationController.pushViewController(creditScoreViewController,
                                                animated: true)
    }
}

extension AppCoordinator: AppCoordinatorDelegate {
    func showCreditScoreDetails(info: CreditScoreInfo) {
        let creditScoreDetailsViewController = CreditScoreDetailsViewController.loadFromNib()
        creditScoreDetailsViewController.viewModel.creditScoreInfo = info
        navigationController.pushViewController(creditScoreDetailsViewController,
                                                animated: true)
    }
}
