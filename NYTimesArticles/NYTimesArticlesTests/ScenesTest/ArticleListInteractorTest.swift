//
//  ArticleListInteractorTest.swift
//  NYTimesArticlesTests
//
//  Created by Sharon Varghese on 30/04/2023.
//

import XCTest
@testable import NYTimesArticles

final class ArticleListInteractorTest: XCTestCase {
    
    var sut: ArticleListInteractor!
    var presentorSpy: ArticleListPresenterSpy!
    var workerSpy: ArticleListWorkerSpy!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        //Given
        sut = ArticleListInteractor()
        presentorSpy = ArticleListPresenterSpy()
        workerSpy = ArticleListWorkerSpy()
    }

    func testFetchArticlesCallsWorkerToFetch() {
        //When
        sut.fetchArticles(numberOfDays: 1) { result in
        //Then
        XCTAssert(self.workerSpy.fetchArticlesCalled, "fetchArticles() should ask worker to fetch articles")
        }
    }
    
    func testFetchArticlesCallsPresenterToFormatArticles() {
        sut.fetchArticles(numberOfDays: 1) { result in
        //Then
            XCTAssert(self.presentorSpy.presentArticlesCalled, "fetchArticles() should ask presenter to format articles")
        }
    }
    
    
    override func tearDownWithError() throws {

    }

}
class ArticleListPresenterSpy: ArticleListPresentationLogic {
    var presentArticlesCalled = false
    func presentArticleList(response: NYTimesArticles.ArticleList.FetchArticleList.Response) {
        presentArticlesCalled = true
    }
    
    
}
enum PossibleFetchArticleResults {
    case success
    case error
}

class ArticleListWorkerSpy: ArticleListWorker {
    
    var articles: [Article]?
    var fetchArticlesCalled = false
    var result: PossibleFetchArticleResults = .success
    override func fetchArticles(numberOfDays: Int, completion: @escaping (Result<[Article]?, ErrorInfo>) -> ()) {
        switch result {
        case .success:
            fetchArticlesCalled = true
            articles = getMockArticles()
            completion(.success(self.articles))
        case .error:
            fetchArticlesCalled = true
            let error = ErrorInfo()
            completion(.failure(error))
        }
        
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

