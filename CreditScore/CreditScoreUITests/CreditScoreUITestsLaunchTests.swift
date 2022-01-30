//
//  CreditScoreUITestsLaunchTests.swift
//  CreditScoreUITests
//
//  Created by Vivek Jayakumar on 26/1/22.
//

import XCTest

class CreditScoreUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunch() throws {
        let app = XCUIApplication()
        app.launchArguments.append("UITesting")
        app.launch()

        let label = app.staticTexts["200"]
        XCTAssertTrue(label.waitForExistence(timeout: 10))        
    }

    
}
