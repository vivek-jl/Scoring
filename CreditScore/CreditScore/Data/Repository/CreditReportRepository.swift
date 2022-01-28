//
//  CreditReportRepository.swift
//  CreditScore
//
//  Created by Vivek Jayakumar on 27/1/22.
//

import Foundation
import Combine
import Resolver

protocol CreditReportRepositoryType {
    func getReport() -> AnyPublisher<CreditScoreDTO, APIError>
}

struct RemoteCreditReportRepository: CreditReportRepositoryType {
    
    @Injected var apiClient: APIClientType
    
    func getReport() -> AnyPublisher<CreditScoreDTO, APIError> {
        return apiClient.request(type: CreditScoreDTO.self, endpoint: ClearScoreEndpoint())
    }

}
