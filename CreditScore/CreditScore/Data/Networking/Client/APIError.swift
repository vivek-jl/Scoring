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
            var errorToReport = error.localizedDescription
            switch error {
            case let .dataCorrupted(context):
                let details = context.underlyingError?.localizedDescription ?? context.codingPath
                    .map { $0.stringValue }.joined(separator: ".")
                errorToReport = "\(context.debugDescription) - (\(details))"
            case let .keyNotFound(key, context):
                let details = context.underlyingError?.localizedDescription ?? context.codingPath
                    .map { $0.stringValue }.joined(separator: ".")
                errorToReport = "\(context.debugDescription) (key: \(key), \(details))"
            case let .typeMismatch(type, context), let .valueNotFound(type, context):
                let details = context.underlyingError?.localizedDescription ?? context.codingPath
                    .map { $0.stringValue }.joined(separator: ".")
                errorToReport = "\(context.debugDescription) (type: \(type), \(details))"
            @unknown default:
                break
            }
            self = APIError.invalidResponse(errorMessage: errorToReport)
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
