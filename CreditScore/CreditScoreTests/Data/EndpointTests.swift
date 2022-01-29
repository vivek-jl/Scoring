//
//  EndpointTests.swift
//  CreditScoreTests
//
//  Created by Vivek Jayakumar on 27/1/22.
//

import XCTest
@testable import CreditScore


class EndpointTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testProdEndpoints() {
        let endpoint = ClearScoreEndpoint()
        XCTAssertEqual(
            endpoint.buildRequest(.production).url?.absoluteString,
            "https://5lfoiyb0b3.execute-api.us-west-2.amazonaws.com/prod/mockcredit/values"
        )
    }
    
    func testStagingEndpoints() {
        let endpoint = ClearScoreEndpoint()
        XCTAssertEqual(
            endpoint.buildRequest(.staging).url?.absoluteString,
            "https://5lfoiyb0b3.execute-api.us-west-2.amazonaws.com/staging/mockcredit/values"
        )
    }
}
