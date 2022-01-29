//
//  CreditScoreViewController.swift
//  CreditScore
//
//  Created by Vivek Jayakumar on 29/1/22.
//

import UIKit
import SnapKit
import Combine
import Resolver

class CreditScoreViewController: UIViewController {
    
    @Injected var viewModel: CreditScoreViewModel
    private var cancellable: AnyCancellable?
    
    weak var coordinatorDelegate: AppCoordinatorDelegate?
    
    // MARK: Sub Views
    private lazy var progressView = CircularProgressView()
    private lazy var titleLabel = UILabel()
    private lazy var scoreLabel = UILabel()
    private lazy var totalScoreLabel = UILabel()
    private lazy var navigateToDetailsButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = L10n.Home.navbarTitle
        setupViews()
        observeViewModelChanges()
        viewModel.loadCreditScore()
    }
    
    private func setupViews() {
        
        view.addSubview(progressView)
        progressView.snp.makeConstraints {
            $0.size.equalTo(view.frame.width * 0.6)
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        progressView.startColor = Assets.progressStartColor.color
        progressView.endColor = Assets.progressEndColor.color
        
        view.addSubview(scoreLabel)
        scoreLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        scoreLabel.font = .boldSystemFont(ofSize: 21)
        scoreLabel.textColor = Assets.creditScoreTextColor.color
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(scoreLabel).offset(-30)
        }
        titleLabel.font = .systemFont(ofSize: 14)
        titleLabel.textColor = Assets.subtitleTextColor.color
        
        view.addSubview(totalScoreLabel)
        totalScoreLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(scoreLabel).offset(30)
        }
        totalScoreLabel.font = .systemFont(ofSize: 14)
        totalScoreLabel.textColor = Assets.subtitleTextColor.color
        
        view.addSubview(navigateToDetailsButton)
        navigateToDetailsButton.snp.makeConstraints {
            $0.size.equalTo(view.frame.width * 0.6)
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        navigateToDetailsButton.addTarget(self, action: #selector(showDetails), for: .touchUpInside)

    }
    
    @objc private func showDetails() {
        if let info = viewModel.creditScoreInfo {
            coordinatorDelegate?.showCreditScoreDetails(info: info)
        }
    }
    
    private func observeViewModelChanges() {
        cancellable = viewModel.objectWillChange.sink { [weak self] in
            switch self?.viewModel.state {
            case .idle:
                self?.updateActivityIndicator(status: false)
            case .loading:
                self?.updateActivityIndicator(status: true)
            case .loaded:
                self?.updateActivityIndicator(status: false)
            case .fetchComplete(let creditScore):
                self?.showCreditScore(creditScore)
            case .error(let errorMessage):
                self?.showError(errorMessage)
            case .none:
                return
            }
        }
    }
    
    private func showCreditScore(_ score: CreditScore) {
        titleLabel.text = L10n.Home.title
        totalScoreLabel.text = L10n.Home.subtitle(Int(score.maxScore))
        scoreLabel.text = "\(Int(score.score))"
        progressView.setProgress(Float(score.progressScore), animated: true, completion: nil)
    }
    
    private func updateActivityIndicator(status: Bool) {

    }
    
    private func showError(_ errorMessage: String) {
        
    }
}
