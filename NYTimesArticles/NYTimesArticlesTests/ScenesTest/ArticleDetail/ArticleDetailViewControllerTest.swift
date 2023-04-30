//
//  ArticleDetailViewControllerTest.swift
//  NYTimesArticlesTests
//
//  Created by Sharon Varghese on 30/04/2023.
//

import XCTest
@testable import NYTimesArticles

final class ArticleDetailViewControllerTest: XCTestCase {

    var sut: ArticleDetailViewController!
    var interactorSpy: ArticleDetailInteractorSpy!
    var article: Article?
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = ArticleDetailViewController()
        interactorSpy = ArticleDetailInteractorSpy()
        sut.interactor = interactorSpy
        article = getMockArticle()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: "ArticleDetailViewControllerID") as? ArticleDetailViewController
        sut.loadViewIfNeeded()
    }
    func getMockArticle() -> Article? {
        guard let path = Bundle(for: ArticleNetworkModelTest.self).path(forResource: "MockArticleList", ofType: "json")
        else { fatalError("Can't find search.json file") }
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            let response = try JSONDecoder().decode(ArticleNetworkModel.self, from: data)
            let articles = response.results
            return articles?.first
        } catch {
            print(error)
        }
       
        return nil
    }
    func testShouldDisplaySelectedArticle() {
        
        // Given
        let tableViewSpy = TableViewSpy()
        sut.tableView = tableViewSpy
        // When
        let detail = [Any]()
        sut.displayArticle(detail: detail)
        // Then
        XCTAssert(tableViewSpy.reloadDataCalled, "Displaying fetched articles should reload the table view")
    }

    // MARK: Nil checks
    func testArticleList_TableViewShouldNotBeNil() {
        XCTAssertNotNil(sut.tableView)
    }

    // MARK: DataSource
    func testDataSource_SetsTableViewDataSource() {
        XCTAssertNotNil(sut.tableView.dataSource)
        XCTAssertTrue(sut.tableView?.dataSource is ArticleDetailViewController)
    }
    
    // MARK: Delegate
    func testDelegate_SetsTableViewDelegate()  {
        XCTAssertNotNil(sut.tableView.delegate)
        XCTAssertTrue(sut.tableView?.delegate is ArticleDetailViewController)
    }
    
    func testCell_TitleTableViewCell() {
        let titleData = ArticleDetail.ArticleItem.ViewModel.ArticleTitleModel(title: "Article Title")
        let titleCell = sut.tableView.dequeueReusableCell(withIdentifier: ArticleDetailTitleTableViewCell.reuseIdentifier) as? ArticleDetailTitleTableViewCell
        titleCell?.data = titleData
        XCTAssertEqual(titleCell?.titleLabel.text, "Article Title")
    }
    func testCell_ImageTableViewCell()  {
        let imageData = ArticleDetail.ArticleItem.ViewModel.ArticleImageModel(imageURLString: "nyt://article/48d0e106-7f03-58be-a730-961f2fceab5d")
        let imageCell = sut.tableView.dequeueReusableCell(withIdentifier: ArticleDetailImageTableViewCell.reuseIdentifier) as? ArticleDetailImageTableViewCell
        imageCell?.data = imageData
        XCTAssertNotNil(imageCell?.articleImageView)
    }
    func testCell_DateAndAuthorTableViewCell() {
        let details = ArticleDetail.ArticleItem.ViewModel.ArticleAuthorAndDateModel(author: "Maria Jimenez", date: "Wed,4 April")
        let cell = sut.tableView.dequeueReusableCell(withIdentifier: ArticleDetailDateTableViewCell.reuseIdentifier) as? ArticleDetailDateTableViewCell
        cell?.data = details
        XCTAssertEqual(cell?.dateLabel.text, "Wed,4 April")
        XCTAssertEqual(cell?.byLabel.text, "Maria Jimenez")
    }
    
    func testCell_Description() {
        let details = ArticleDetail.ArticleItem.ViewModel.ArticleDescriptionModel(description: "Article Description")
        let cell = sut.tableView.dequeueReusableCell(withIdentifier: ArticleDetailDescriptionTableViewCell.reuseIdentifier) as? ArticleDetailDescriptionTableViewCell
        cell?.data = details
        XCTAssertEqual(cell?.descriptionLabel.text, "Article Description")
    }

}
//MARK: Interactor Spy
class ArticleDetailInteractorSpy: ArticleDetailBusinessLogic, ArticleDetailDataStore {
    
    var article: Article?
    var showArticlesCalled = false
    func showSelectedArticle() {
        showArticlesCalled = true
    }
    
   
    
    
}
