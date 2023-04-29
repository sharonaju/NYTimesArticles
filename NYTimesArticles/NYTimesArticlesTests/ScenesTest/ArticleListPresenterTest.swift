//
//  ArticleListPresenterTest.swift
//  NYTimesArticlesTests
//
//  Created by Sharon Varghese on 30/04/2023.
//

import XCTest
@testable import NYTimesArticles

final class ArticleListPresenterTest: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testDisplayArticleListCalledByPresentor()  {
        // Given
        let viewControllerSpy = ArticleListViewControllerSpy()
        let sut = ArticleListPresenter()
        sut.viewController = viewControllerSpy
        let articles = getMockArticles()
        let response = ArticleList.FetchArticleList.Response(articles: articles, error: nil)
        // When
        sut.presentArticleList(response: response)
        // Then
        XCTAssert(viewControllerSpy.displayArticleListCalled,"presentArticleList() should ask view controller to display them")
        
    }
    
    func getMockArticles() -> [Article]? {
        guard let path = Bundle(for: ArticleNetworkModelTest.self).path(forResource: "MockArticleList", ofType: "json")
        else { fatalError("Can't find search.json file") }
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            let response = try JSONDecoder().decode(ArticleNetworkModel.self, from: data)
            let articles = response.results
            return articles
        } catch {
            print(error)
        }
       
        return nil
    }

}
// MARK: TestDoubles
class ArticleListViewControllerSpy: UIViewController,ArticleListDisplayLogic {
    var displayArticleListCalled = false
    
    func displayArticleList(viewModel: NYTimesArticles.ArticleList.FetchArticleList.ViewModel) {
        displayArticleListCalled = true
    }
    
    
}

