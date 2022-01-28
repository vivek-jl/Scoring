//
//  Endpoint+Extension.swift
//  CreditScore
//
//  Created by Vivek Jayakumar on 28/1/22.
//

import Foundation

extension EndpointType {
    func pathFor(environment: ServerEnvironment) -> String {
        switch environment {
        case .staging:
            return "/staging/"
        case .production:
            return "/prod/"
        }
    }
    
    func buildURLRequest(components: URLComponents) -> URLRequest {
        guard let url = components.url else {
            preconditionFailure("Invalid URL")
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.timeoutInterval = 20
        return urlRequest
    }
}


