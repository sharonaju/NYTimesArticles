//
//  APIManagerTest.swift
//  NYTimesArticlesTests
//
//  Created by Sharon Varghese on 29/04/2023.
//

import XCTest
@testable import NYTimesArticles

final class APIManagerTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testAPIManagerInit() {
        let apiManager = APIManager.shared()
        XCTAssertNotNil(apiManager)
    }
    func testAPIManager_CallAPISuccess() {
        var response: ArticleNetworkModel?
        var errResponse: ErrorInfo?
        let params = ["api-key" : Secrets.nytAPIKey]
        let expectation = self.expectation(description: "API fetched")
        APIManager.shared().call(type: EndPointItem.viewed(1), params: params) { (result: Swift.Result<ArticleNetworkModel, ErrorInfo>) in
            switch result {
            case .success(let data):
                response = data
                expectation.fulfill()
            case .failure(let error):
                errResponse = error
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 30)
        XCTAssertNotNil(response?.status)
        XCTAssertNil(errResponse?.body)
    }
    
    func testAPIManager_CallAPIFailure() {
        var response: ArticleNetworkModel?
        var errResponse: ErrorInfo?
        let params = ["api-key" : "abc"]
        let expectation = self.expectation(description: "API fetched")
        APIManager.shared().call(type: EndPointItem.viewed(1), params: params) { (result: Swift.Result<ArticleNetworkModel, ErrorInfo>) in
            switch result {
            case .success(let data):
                response = data
                expectation.fulfill()
            case .failure(let error):
                errResponse = error
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 30)
        XCTAssertNil(response?.status)
        XCTAssertNotNil(errResponse?.body)
    }
    
    func testErrorParseWhenNoData() {
        let errorInfo = APIManager.shared().parseApiError()
        XCTAssertNil(errorInfo)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
