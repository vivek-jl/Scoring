//
//  FetchCreditScoreUseCase.swift
//  CreditScore
//
//  Created by Vivek Jayakumar on 28/1/22.
//

import Foundation
import Combine
import Resolver

protocol FetchCreditScoreUseCaseType {
    func fetchCreditScore() -> AnyPublisher<CreditScore, APIError>
}

struct FetchCreditScoreUseCase: FetchCreditScoreUseCaseType {
    
    @Injected var creditScoreRepo: CreditReportRepositoryType
    
    func fetchCreditScore() -> AnyPublisher<CreditScore, APIError> {
        return creditScoreRepo.getReport()
    }
}
