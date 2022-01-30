//
//  Resolver+XCTests.swift
//  CreditScoreTests
//
//  Created by Vivek Jayakumar on 27/1/22.
//

import Foundation
import Resolver
@testable import CreditScore

extension Resolver {
    
    static var test: Resolver!
    
    static func resetUnitTestRegistrations() {
        Resolver.test = Resolver(child: .main)
        Resolver.root = Resolver.test
        Resolver.test.register { MockFetchCreditScoreUseCase()}
        .implements(FetchCreditScoreUseCaseType.self)
        Resolver.test.register { MockCreditScoreRepository()}
        .implements(CreditScoreRepositoryType.self)
        Resolver.test.register { BaseURL() }.implements(BaseURLType.self)
        Resolver.test.register { ServerEnvironment.staging }
        Resolver.test.register { URLSessionConfiguration.ephemeral }
        Resolver.test.register { MockAPIClient(configuration: resolve(), environment: resolve()) }
        .implements(APIClientType.self)
    }
}
