//
//  ArticleDetailTitleTableViewCellTest.swift
//  NYTimesArticlesTests
//
//  Created by Sharon Varghese on 30/04/2023.
//

import XCTest
@testable import NYTimesArticles

final class ArticleDetailTitleTableViewCellTest: XCTestCase {
    var sut: ArticleDetailTitleTableViewCell!
    
    override func setUpWithError() throws {
        sut = ArticleDetailTitleTableViewCell()
    }

//    func testLoadData() {
//        //Given
//        let data = ArticleDetail.ArticleItem.ViewModel.ArticleTitleModel(title: "Article title")
//        //When
//        sut.loadData()
//        //Then
//        XCTAssertEqual(sut.titleLabel.text, "Article title")
//        
//    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }


}
