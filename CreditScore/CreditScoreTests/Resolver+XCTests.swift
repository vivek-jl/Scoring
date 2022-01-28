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
        Resolver.test.register { ServerEnvironment.staging }
        register { MockAPIClient(configuration: <#URLSessionConfiguration#>, environment: <#ServerEnvironment#>) }.implements(APIClientType.self)
    }
}
