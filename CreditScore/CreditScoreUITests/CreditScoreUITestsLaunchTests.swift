//
//  CreditScoreUITestsLaunchTests.swift
//  CreditScoreUITests
//
//  Created by Vivek Jayakumar on 26/1/22.
//

import XCTest

class CreditScoreUITestsLaunchTests: XCTestCase {

    var app: XCUIApplication!

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }
    

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments.append("UITesting")
        app.launch()
        sleep(1)
    }
    
    func testLaunch() throws {
        let label = app.staticTexts["200"]
        XCTAssertTrue(label.waitForExistence(timeout: 10))
    }
    
}

extension XCUIElement {
    func tap(wait: Int, test: XCTestCase) {
        if !isHittable {
            test.expectation(for: NSPredicate(format: "hittable == true"), evaluatedWith: self, handler: nil)
            test.waitForExpectations(timeout: TimeInterval(wait), handler: nil)
        }
        tap()
    }
}
