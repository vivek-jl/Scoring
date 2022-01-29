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
        let uiTesting = ProcessInfo.processInfo.arguments.contains("UITesting")
        if uiTesting == true {
            return Just( CreditScore(score: 200, minScore: 0, maxScore: 700))
                .setFailureType(to: APIError.self)
                .eraseToAnyPublisher()
           
          } else {
              return apiClient.request(type: CreditScoreDTO.self, endpoint: ClearScoreEndpoint())
                  .map { mapToDomain(score: $0) }
                  .eraseToAnyPublisher()
          }
        
    }
    
    private func mapToDomain(score: CreditScoreDTO) -> CreditScore {
        return CreditScore(score: score.creditReportInfo.score,
                           minScore: score.creditReportInfo.minScoreValue,
                           maxScore: score.creditReportInfo.maxScoreValue)
    }

}
