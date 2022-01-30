//
//  FakeFetchCreditScoreUseCase.swift
//  CreditScoreTests
//
//  Created by Vivek Jayakumar on 29/1/22.
//

import Foundation
import Combine
import Resolver
@testable import CreditScore

final class MockFetchCreditScoreUseCase: FetchCreditScoreUseCaseType {
    
    var isSuccess = true
    var callCount = 0
    
    func fetchCreditScore() -> AnyPublisher<CreditScore, APIError> {
        callCount += 1
        if isSuccess == true {
            let creditScore = CreditScore(score: 200, minScore: 0, maxScore: 500)
            return Just(creditScore)
                .setFailureType(to: APIError.self)
                .eraseToAnyPublisher()
        } else {
            return Fail(error: APIError.invalidResponse(errorMessage: "Mock Error"))
                .eraseToAnyPublisher()
        }
    }

}
