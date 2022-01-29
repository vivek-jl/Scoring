//
//  AppDelegate+Resolver.swift
//  CreditScore
//
//  Created by Vivek Jayakumar on 27/1/22.
//

import Foundation
import Resolver

extension Resolver: ResolverRegistering {
    public static func registerAllServices() {
        defaultScope = .graph
        register { BaseURL() }.implements(BaseURLType.self)
        register { URLSessionConfiguration.default }
        register { ServerEnvironment.staging }
        register { APIClient() }.implements(APIClientType.self)
    }
}
