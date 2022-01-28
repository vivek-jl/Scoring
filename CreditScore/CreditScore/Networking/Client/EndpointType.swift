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
    var timeout: Double { get }
    func buildRequest(_ environment: ServerEnvironment) -> URLRequest
}


