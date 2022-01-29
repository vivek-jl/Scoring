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
        register { ServerEnvironment.production }
        register { FetchCreditScoreUseCase() }
        .implements(FetchCreditScoreUseCaseType.self)
        register { RemoteCreditScoreRepository() }
        .implements(CreditScoreRepositoryType.self)
        register { APIClient() }.implements(APIClientType.self)
        register { CreditScoreViewModel() }
    }
}
