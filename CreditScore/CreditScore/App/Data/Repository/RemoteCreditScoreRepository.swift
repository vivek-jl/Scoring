//
//  CreditReportRepository.swift
//  CreditScore
//
//  Created by Vivek Jayakumar on 27/1/22.
//

import Foundation
import Combine
import Resolver

struct RemoteCreditScoreRepository: CreditScoreRepositoryType {
    
    @Injected var apiClient: APIClientType
    
    func getReport() -> AnyPublisher<CreditScore, APIError> {
        apiClient.request(type: CreditScoreDTO.self, endpoint: ClearScoreEndpoint())
            .map { mapToDomain(score: $0) }
            .eraseToAnyPublisher()
    }
    
    private func mapToDomain(score: CreditScoreDTO) -> CreditScore {
        return CreditScore(score: score.creditReportInfo.score,
                           minScore: score.creditReportInfo.minScoreValue,
                           maxScore: score.creditReportInfo.maxScoreValue)
    }

}
