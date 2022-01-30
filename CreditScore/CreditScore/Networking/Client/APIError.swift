//
//  APIError.swift
//  CreditScore
//
//  Created by Vivek Jayakumar on 26/1/22.
//

import Foundation

enum APIError: Error, Equatable {
    case failedRequest(statusCode: Int)
    case invalidResponse(errorMessage: String)
    case unknown(errorMessage: String)
    case noData

    init(from error: Error) {
        if let apiError = error as? APIError {
            self = apiError
            return
        }
        if let error = error as? DecodingError {
            self = APIError.invalidResponse(errorMessage: error.failureReason ?? error.localizedDescription)
            return
        }
        self = APIError.unknown(errorMessage: error.localizedDescription)
    }

    var errorDescription: String {
        let requestFailedMessage = "Error in Request.\nError Message: "
        switch self {
        case let .invalidResponse(errorMessage): return "\(requestFailedMessage) \(errorMessage)"
        case let .failedRequest(statusCode): return "\(requestFailedMessage) Request failed to load.\nStatus Code: \(statusCode)"
        case let .unknown(errorMessage): return "\(requestFailedMessage) \(errorMessage)"
        case .noData: return "\(requestFailedMessage) No data from server"
        }
    }
}
