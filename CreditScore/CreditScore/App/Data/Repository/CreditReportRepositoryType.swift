//
//  CreditReportRepositoryType.swift
//  CreditScore
//
//  Created by Vivek Jayakumar on 28/1/22.
//

import Foundation
import Combine

protocol CreditReportRepositoryType {
    func getReport() -> AnyPublisher<CreditScore, APIError>
}
