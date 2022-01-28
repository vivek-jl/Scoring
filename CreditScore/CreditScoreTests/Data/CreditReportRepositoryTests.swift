//
//  CreditReportRepositoryTests.swift
//  CreditScoreTests
//
//  Created by Vivek Jayakumar on 28/1/22.
//

import XCTest
import Resolver
import Combine
@testable import CreditScore


class CreditReportRepositoryTests: XCTestCase {
    
    private var sut: RemoteCreditReportRepository?
    private var cancellables: Set<AnyCancellable>!

    override func setUpWithError() throws {
        Resolver.resetUnitTestRegistrations()
        cancellables = []
        sut = RemoteCreditReportRepository()
    }
    
    override func tearDownWithError() throws {
        sut = nil
    }
  
    func testLoadCreditReport() throws {
        let bundle = Bundle(for: type(of: self))
        guard let url = bundle.url(forResource: "CreditScoreSample",
                                   withExtension: "json") else {
            XCTFail("Missing file: CreditScoreSample.json")
            return
        }
        do {
            let json = try Data(contentsOf: url)
            let score: CreditScoreDTO = try JSONDecoder()
                .decode(CreditScoreDTO.self, from: json)
        
            let mockAPIClient  = sut?.apiClient as! MockAPIClient
            mockAPIClient.modelItem = score
            
            let fetchCompleted = XCTestExpectation(description: "CreditScore Fetch Completed")
            defer {
                self.wait(for: [fetchCompleted], timeout: 5)
            }
            var object: CreditScoreDTO? = nil
            var error: Error?

            sut?.getReport()
                .sink(receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        break
                    case let .failure(encounteredError):
                        error = encounteredError
                    }
                    XCTAssertNil(error)
                    XCTAssertNotNil(object)
                    XCTAssertEqual(object?.creditReportInfo.score, 514)
                    XCTAssertEqual(object?.creditReportInfo.maxScoreValue, 700)
                    XCTAssertEqual(object?.creditReportInfo.minScoreValue, 0)
                    fetchCompleted.fulfill()
                }, receiveValue: { value in
                    object = value
                })
                .store(in: &cancellables)
            
        } catch {
            XCTFail("Unable to parse JSON")
        }
       
    }
    
}
