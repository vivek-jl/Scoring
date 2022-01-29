//
//  CreditScoreViewController.swift
//  CreditScore
//
//  Created by Vivek Jayakumar on 29/1/22.
//

import UIKit
import SnapKit
import Resolver

class CreditScoreViewController: UIViewController {

    @Injected var viewModel: CreditScoreViewModel
    
    private lazy var progressView = CircularProgressView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Dashboard"
        viewModel.loadCreditScore()
        
        view.addSubview(progressView)

        progressView.snp.makeConstraints {
            $0.size.equalTo(view.frame.width * 0.6)
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        
        progressView.setProgress(0.5, animated: true, completion: nil)
    }
}
