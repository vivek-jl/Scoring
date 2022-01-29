//
//  ClearscoreEndpoint.swift
//  CreditScore
//
//  Created by Vivek Jayakumar on 26/1/22.
//

import Foundation
import Resolver

struct ClearScoreEndpoint: EndpointType {
    @Injected var baseURL: BaseURLType
    var payload: HTTPParameters? = nil
    var method: HTTPMethod = .get
    var subPath: String = "mockcredit/values"
    var headers: HTTPHeaders? = nil
    var timeout: Double = 20

    func buildRequest(_ environment: ServerEnvironment) -> URLRequest {
        var components = URLComponents()
        components.scheme = "https"
        components.host = baseURL.domain
        components.path = pathFor(environment: environment) + subPath
        components.queryItems = nil
        return buildURLRequest(components: components)
    }
}
