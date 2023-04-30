//
//  NYTimesArticlesUITests.swift
//  NYTimesArticlesUITests
//
//  Created by Sharon Varghese on 30/04/2023.
//

import XCTest

final class NYTimesArticlesUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSegmentedControl() {
        let app = XCUIApplication()
        app.launch()
        XCTAssertTrue(app.segmentedControls.buttons["1 Day"].exists)
        XCTAssertTrue(app.segmentedControls.buttons["7 Days"].exists)
        XCTAssertTrue(app.segmentedControls.buttons["30 Days"].exists)
    }
    func testTableView() {
        let app = XCUIApplication()
        app.launch()
        let tableView = app.tables["ArticleListTableView"]
        XCTAssertTrue(tableView.exists)
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
