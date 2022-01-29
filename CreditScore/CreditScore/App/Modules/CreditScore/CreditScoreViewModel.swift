//
//  CreditScoreViewModel.swift
//  CreditScore
//
//  Created by Vivek Jayakumar on 29/1/22.
//

import Foundation
import Combine
import Resolver

final class CreditScoreViewModel: ObservableObject {
    
    @Injected var useCase: FetchCreditScoreUseCaseType
    @Published var state: CreditScoreViewModel.State = .idle
    
    private var subscribers = Set<AnyCancellable>()

    enum State: Equatable {
        case idle
        case loading
        case loaded
        case fetchComplete(CreditScore)
        case error(String)
    }
}

extension CreditScoreViewModel {
    func loadCreditScore() {
        useCase.fetchCreditScore()
            .sink(
                receiveCompletion: { [weak self] completion in
                    self?.state = .loaded
                    if case let .failure(error) = completion {
                        self?.state = .error(error.errorDescription)
                    }
                },
                receiveValue: { [weak self] score in
                    print(score)
                    self?.state = .fetchComplete(score)
                }
            ).store(in: &subscribers)
    }
}
