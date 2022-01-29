//
//  CreditScoreViewController.swift
//  CreditScore
//
//  Created by Vivek Jayakumar on 29/1/22.
//

import UIKit
import Resolver

class CreditScoreViewController: UIViewController {

    @Injected var viewModel: CreditScoreViewModel
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.loadCreditScore()
        // Do any additional setup after loading the view.
    }
}
