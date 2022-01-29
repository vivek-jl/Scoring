//
//  CreditScoreViewController.swift
//  CreditScore
//
//  Created by Vivek Jayakumar on 29/1/22.
//

import UIKit
import SnapKit
import Combine
import PKHUD
import Resolver

class CreditScoreViewController: UIViewController {

    @Injected var viewModel: CreditScoreViewModel
    private var cancellable: AnyCancellable?

    // MARK: Sub Views
    private lazy var progressView = CircularProgressView()
    private lazy var titleLabel = UILabel()
    private lazy var scoreLabel = UILabel()
    private lazy var totalScoreLabel = UILabel()

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
        titleLabel.text = L10n.Home.title
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(scoreLabel).offset(-30)
        }
        titleLabel.font = .systemFont(ofSize: 14)
        titleLabel.textColor = Assets.subtitleTextColor.color
        
        view.addSubview(totalScoreLabel)
        totalScoreLabel.text = L10n.Home.subtitle(700)
        totalScoreLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(scoreLabel).offset(30)
        }
        totalScoreLabel.font = .systemFont(ofSize: 14)
        totalScoreLabel.textColor = Assets.subtitleTextColor.color
        
    }
    
    private func observeViewModelChanges() {
        cancellable = viewModel.objectWillChange.sink { [weak self] in
            switch self?.viewModel.state {
            case .idle:
                PKHUD.sharedHUD.hide()
            case .loading:
                PKHUD.sharedHUD.show()
            case .loaded:
                PKHUD.sharedHUD.hide()
            case .fetchComplete(let creditScore):
                self?.scoreLabel.text = "\(creditScore.score)"
                self?.progressView.setProgress(0.5, animated: true, completion: nil)
            default:
                return
        }
    }
    }
}
