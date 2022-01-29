//
//  MockCreditScoreRepository.swift
//  CreditScoreTests
//
//  Created by Vivek Jayakumar on 29/1/22.
//

import Foundation
import Combine
@testable import CreditScore

final class MockCreditScoreRepository: CreditScoreRepositoryType {
    var isSuccess = true
    var getReportCallCount = 0
    
    func getReport() -> AnyPublisher<CreditScore, APIError> {
        getReportCallCount += 1
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
