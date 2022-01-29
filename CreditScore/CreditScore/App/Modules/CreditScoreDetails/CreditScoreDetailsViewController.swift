//
//  CreditScoreDetailsViewController.swift
//  CreditScore
//
//  Created by Vivek Jayakumar on 29/1/22.
//

import UIKit
import Resolver

class CreditScoreDetailsViewController: UIViewController {

    @Injected var viewModel: CreditScoreDetailsViewModel
    
    private lazy var monthsSinceLastDefaultedLabel = UILabel()
    private lazy var monthsSinceLastDefaultedValueLabel = UILabel()

    private lazy var percentageCreditUsedLabel = UILabel()
    private lazy var percentageCreditUsedValueLabel = UILabel()

    private lazy var currentLongTermDebtLabel = UILabel()
    private lazy var currentLongTermDebtValueLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        showData()
    }
    
    private func setupViews() {
        view.addSubview(monthsSinceLastDefaultedLabel)
        monthsSinceLastDefaultedLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            $0.leading.equalTo(view).offset(30)

        }
        monthsSinceLastDefaultedLabel.font = .boldSystemFont(ofSize: 14)
        monthsSinceLastDefaultedLabel.text = L10n.Details.monthsSinceLastDefaulted
        monthsSinceLastDefaultedLabel.textColor = Assets.subtitleTextColor.color
        
        view.addSubview(monthsSinceLastDefaultedValueLabel)
        monthsSinceLastDefaultedValueLabel.snp.makeConstraints {
            $0.top.equalTo(monthsSinceLastDefaultedLabel)
            $0.leading.equalTo(monthsSinceLastDefaultedLabel.snp.trailing).offset(20)

        }
        monthsSinceLastDefaultedValueLabel.font = .systemFont(ofSize: 14)
        monthsSinceLastDefaultedValueLabel.text = L10n.Details.monthsSinceLastDefaulted
        monthsSinceLastDefaultedValueLabel.textColor = Assets.subtitleTextColor.color
        
        view.addSubview(percentageCreditUsedLabel)
        percentageCreditUsedLabel.snp.makeConstraints {
            $0.top.equalTo(monthsSinceLastDefaultedLabel.snp.bottom).offset(30)
            $0.leading.equalTo(view).offset(30)

        }
        percentageCreditUsedLabel.font = .boldSystemFont(ofSize: 14)
        percentageCreditUsedLabel.text = L10n.Details.percentageCreditUsed
        percentageCreditUsedLabel.textColor = Assets.subtitleTextColor.color
        
        view.addSubview(percentageCreditUsedValueLabel)
        percentageCreditUsedValueLabel.snp.makeConstraints {
            $0.top.equalTo(percentageCreditUsedLabel)
            $0.leading.equalTo(percentageCreditUsedLabel.snp.trailing).offset(20)

        }
        percentageCreditUsedValueLabel.font = .systemFont(ofSize: 14)
        percentageCreditUsedValueLabel.text = L10n.Details.monthsSinceLastDefaulted
        percentageCreditUsedValueLabel.textColor = Assets.subtitleTextColor.color
        
        view.addSubview(currentLongTermDebtLabel)
        currentLongTermDebtLabel.snp.makeConstraints {
            $0.top.equalTo(percentageCreditUsedLabel.snp.bottom).offset(30)
            $0.leading.equalTo(view).offset(30)

        }
        currentLongTermDebtLabel.font = .boldSystemFont(ofSize: 14)
        currentLongTermDebtLabel.text = L10n.Details.currentLongTermDebt
        currentLongTermDebtLabel.textColor = Assets.subtitleTextColor.color
        
        view.addSubview(currentLongTermDebtValueLabel)
        currentLongTermDebtValueLabel.snp.makeConstraints {
            $0.top.equalTo(currentLongTermDebtLabel)
            $0.leading.equalTo(currentLongTermDebtLabel.snp.trailing).offset(20)

        }
        currentLongTermDebtValueLabel.font = .systemFont(ofSize: 14)
        currentLongTermDebtValueLabel.text = L10n.Details.monthsSinceLastDefaulted
        currentLongTermDebtValueLabel.textColor = Assets.subtitleTextColor.color
        
    }
    
    private func showData() {
        monthsSinceLastDefaultedValueLabel.text = "\(viewModel.creditScoreInfo?.monthsSinceLastDefaulted ?? 0)"
        percentageCreditUsedValueLabel.text = "\(viewModel.creditScoreInfo?.percentageCreditUsed ?? 0)%"
        currentLongTermDebtValueLabel.text = "\(viewModel.creditScoreInfo?.currentLongTermDebt ?? 0)"

    }
}
