//
//  CreditScoreUseCaseTests.swift
//  CreditScoreTests
//
//  Created by Vivek Jayakumar on 29/1/22.
//

import XCTest
import Combine
import Resolver
@testable import CreditScore

class CreditScoreUseCaseTests: XCTestCase {
    private var cancellables: Set<AnyCancellable>!

    private var sut: FetchCreditScoreUseCase?
    override func setUpWithError() throws {
        sut = FetchCreditScoreUseCase()
        Resolver.resetUnitTestRegistrations()
        cancellables = []
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testSuccesfulRepoCall() {
        let mockRepo  = sut?.creditScoreRepo as! MockCreditScoreRepository
        let fetchCompleted = XCTestExpectation(description: "CreditScore Use Case Fetch Completed")
        defer {
            self.wait(for: [fetchCompleted], timeout: 5)
        }
        var object: CreditScore? = nil
        var error: Error?
        
        sut?.fetchCreditScore()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case let .failure(encounteredError):
                    error = encounteredError
                }
                XCTAssertNil(error)
                XCTAssertEqual(mockRepo.getReportCallCount, 1)
                XCTAssertEqual(object?.score, 200)
                XCTAssertEqual(object?.maxScore, 500)
                XCTAssertEqual(object?.minScore, 0)
                fetchCompleted.fulfill()
            }, receiveValue: { value in
                object = value
            })
            .store(in: &cancellables)
    }
    
}
