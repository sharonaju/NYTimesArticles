//
//  String+ExtensionTest.swift
//  NYTimesArticlesTests
//
//  Created by Sharon Varghese on 30/04/2023.
//

import XCTest
@testable import NYTimesArticles

final class String_ExtensionTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDateFormatting() {
        //Given
        let inputdate =  "2023-04-29 23:51:44"
        
        //When
        let outputDate = inputdate.dateFormatted
        
        //Then
        XCTAssertEqual(outputDate, "Sat, 29 Apr,2023")
    }
    

}
