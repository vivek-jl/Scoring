//
//  CreditScoreViewModelTests.swift
//  CreditScoreTests
//
//  Created by Vivek Jayakumar on 29/1/22.
//

import XCTest
import Combine
import Resolver
@testable import CreditScore

class CreditScoreViewModelTests: XCTestCase {
        
    private var sut: CreditScoreViewModel?
    
    override func setUpWithError() throws {
        Resolver.resetUnitTestRegistrations()
        sut = CreditScoreViewModel()
    }
    
    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testFetchCreditScore() {
        let mockUseCase  = sut?.useCase as! MockFetchCreditScoreUseCase
        let fetchCompleted = XCTestExpectation(description: "CreditScore ViewModel Fetch Completed")
      
        sut?.loadCreditScore()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertEqual(mockUseCase.callCount, 1)
            guard case .fetchComplete(_) = self.sut?.state else {
                   XCTFail("Fetch complete was expected")
                   return
               }
            fetchCompleted.fulfill()
            self.wait(for: [fetchCompleted], timeout: 1)
        }
    }
}
