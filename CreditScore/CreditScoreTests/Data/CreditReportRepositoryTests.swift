//
//  CreditReportRepositoryTests.swift
//  CreditScoreTests
//
//  Created by Vivek Jayakumar on 28/1/22.
//

import XCTest
import Resolver
@testable import CreditScore


class CreditReportRepositoryTests: XCTestCase {

    private var sut: RemoteCreditReportRepository?
    
    override func setUpWithError() throws {
        Resolver.resetUnitTestRegistrations()
        sut = RemoteCreditReportRepository()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testLoadCreditReport() throws {

    }

}
