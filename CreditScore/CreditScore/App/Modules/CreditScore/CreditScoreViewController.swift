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
    private var cancellables: Set<AnyCancellable> = []
    
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
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh,
                                                           target: self,
                                                           action: #selector(loadCreditScore))
        setupViews()
        observeViewModelChanges()
        loadCreditScore()
    }
    
    @objc private func loadCreditScore() {
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
        progressView.accessibilityIdentifier = "home_progress"
        
        view.addSubview(scoreLabel)
        scoreLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        scoreLabel.font = .boldSystemFont(ofSize: 21)
        scoreLabel.textColor = Assets.creditScoreTextColor.color
        scoreLabel.accessibilityIdentifier = "home_score"
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(scoreLabel).offset(-30)
        }
        titleLabel.font = .systemFont(ofSize: 14)
        titleLabel.textColor = Assets.subtitleTextColor.color
        titleLabel.accessibilityIdentifier = "home_title"
        
        
        view.addSubview(totalScoreLabel)
        totalScoreLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(scoreLabel).offset(30)
        }
        totalScoreLabel.font = .systemFont(ofSize: 14)
        totalScoreLabel.textColor = Assets.subtitleTextColor.color
        totalScoreLabel.accessibilityIdentifier = "home_total_score"
        
        
        
        view.addSubview(navigateToDetailsButton)
        navigateToDetailsButton.isEnabled = false
        navigateToDetailsButton.snp.makeConstraints {
            $0.size.equalTo(view.frame.width * 0.6)
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        navigateToDetailsButton.addTarget(self, action: #selector(showDetails), for: .touchUpInside)
        navigateToDetailsButton.accessibilityIdentifier = "home_navigate"
        
    }
    
    @objc private func showDetails() {
        if let info = viewModel.creditScoreInfo {
            coordinatorDelegate?.showCreditScoreDetails(info: info)
        }
    }
    
    private func observeViewModelChanges() {
        viewModel.$state.sink { [weak self] state in
            switch state {
            case .loading:
                self?.updateActivityIndicator(status: true)
            case .fetchComplete(let creditScore):
                self?.updateActivityIndicator(status: false)
                self?.showCreditScore(creditScore)
            case .error(let errorMessage):
                self?.updateActivityIndicator(status: false)
                self?.showError(errorMessage)
            case .none:
                return
            }
        }.store(in: &cancellables)
    }
    
    private func showCreditScore(_ score: CreditScore) {
        navigateToDetailsButton.isEnabled = true
        titleLabel.text = L10n.Home.title
        totalScoreLabel.text = L10n.Home.subtitle(Int(score.maxScore))
        scoreLabel.text = "\(Int(score.score))"
        progressView.setProgress(Float(score.progressScore), animated: true, completion: nil)
    }
    
    private func updateActivityIndicator(status: Bool) {
        
    }
    
    private func showError(_ errorMessage: String?) {
        let alert = UIAlertController(title: L10n.Home.errorTitle,
                                      message: "\(L10n.Home.errorDetails). \(errorMessage ?? "")",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: L10n.General.ok, style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
