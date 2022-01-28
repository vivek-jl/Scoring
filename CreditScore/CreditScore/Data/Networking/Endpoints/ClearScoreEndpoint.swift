//
//  ClearscoreEndpoint.swift
//  CreditScore
//
//  Created by Vivek Jayakumar on 26/1/22.
//

import Foundation

struct ClearScoreEndpoint: EndpointType {
    var payload: HTTPParameters? = nil
    var method: HTTPMethod = .get
    var subPath: String = "mockcredit/values"
    var headers: HTTPHeaders? = nil

    func buildRequest(_ environment: ServerEnvironment) -> URLRequest {
        var components = URLComponents()
        components.scheme = "https"
        components.host = BaseURL.clearscoreBaseURL
        components.path = pathFor(environment: environment) + subPath
        components.queryItems = nil

        guard let url = components.url else {
            preconditionFailure("Invalid URL")
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.timeoutInterval = 20

        return urlRequest
    }
}
