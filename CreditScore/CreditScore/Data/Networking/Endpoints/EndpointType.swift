//
//  EndpointType.swift
//  CreditScore
//
//  Created by Vivek Jayakumar on 26/1/22.
//

import Foundation

typealias HTTPParameters = [String: Any]

typealias HTTPHeaders = [String: String]

protocol EndpointType {
    var method: HTTPMethod { get }
    var headers: HTTPHeaders? { get set }
    var payload: HTTPParameters? { get set }
    var subPath: String { get }
    func buildRequest(_ environment: ServerEnvironment) -> URLRequest
}

extension EndpointType {
    func pathFor(environment: ServerEnvironment) -> String {
        switch environment {
        case .staging:
            return "/staging/"
        case .production:
            return "/prod/"
        }
    }
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

