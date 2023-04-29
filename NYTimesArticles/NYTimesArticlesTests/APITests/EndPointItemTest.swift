//
//  EndPointItemTest.swift
//  NYTimesArticlesTests
//
//  Created by Sharon Varghese on 29/04/2023.
//

import XCTest
@testable import NYTimesArticles

final class EndPointItemTest: XCTestCase {

    let sut = EndPointItem.viewed(1)
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testBaseURL() {
        let baseURL = sut.baseURL
        XCTAssertEqual(baseURL, "http://api.nytimes.com/svc/mostpopular/")
    }

    func testPath() {
        let path = sut.path
        XCTAssertEqual(path, "viewed/1.json")
    }
    
    func testHTTPMethod() {
        let httpMethod = sut.httpMethod
        XCTAssertEqual(httpMethod, .get)
    }
    
    func testVersion() {
        let version = sut.version
        XCTAssertEqual(version, "v2/")
    }
    
    func testURL() {
        let url = sut.url
        XCTAssertEqual(url, URL(string: "http://api.nytimes.com/svc/mostpopular/v2/viewed/1.json"))
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
