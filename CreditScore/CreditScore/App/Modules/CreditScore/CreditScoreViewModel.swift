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
    @Published var state: CreditScoreViewModel.State?
    @Published var creditScoreInfo: CreditScoreInfo?
    
    private var subscribers = Set<AnyCancellable>()

    enum State: Equatable {
        case loading
        case fetchComplete(CreditScore)
        case error(String?)
    }
}

extension CreditScoreViewModel {
    func loadCreditScore() {
       // state = .loading
        useCase.fetchCreditScore()
            .sink(
                receiveCompletion: { [weak self] completion in
                    if case let .failure(error) = completion {
                        self?.state = .error(error.errorDescription)
                        print(error.errorDescription)
                    }
                },
                receiveValue: { [weak self] score in
                    print(score)
                    self?.state = .fetchComplete(score)
                    self?.creditScoreInfo = score.creditScoreInfo
                }
            ).store(in: &subscribers)
    }
}
