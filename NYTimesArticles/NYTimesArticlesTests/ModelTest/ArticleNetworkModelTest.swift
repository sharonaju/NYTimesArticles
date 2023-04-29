//
//  ArticleNetworkModelTest.swift
//  NYTimesArticlesTests
//
//  Created by Sharon Varghese on 30/04/2023.
//

import XCTest
@testable import NYTimesArticles

final class ArticleNetworkModelTest: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testArticleNetworkModelResponse() throws {
        guard let path = Bundle(for: ArticleNetworkModelTest.self).path(forResource: "MockArticleList", ofType: "json")
        else { fatalError("Can't find search.json file") }
        let data = try Data(contentsOf: URL(fileURLWithPath: path))
        let response = try JSONDecoder().decode(ArticleNetworkModel.self, from: data)
        let articles = response.results
        XCTAssertEqual(articles?.count, 20)
        let article = articles?.first
        XCTAssertEqual(article?.title, "Julie Powell, Food Writer Known for ‘Julie & Julia,’ Dies at 49")
    }

}
