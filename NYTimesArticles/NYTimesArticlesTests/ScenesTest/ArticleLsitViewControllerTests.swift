//
//  ArticleLsitViewControllerTests.swift
//  NYTimesArticlesTests
//
//  Created by Sharon Varghese on 30/04/2023.
//

import XCTest
@testable import NYTimesArticles
final class ArticleLsitViewControllerTests: XCTestCase {

    var sut: ArticleListViewController!
    var interactorSpy: ArticleListInteractorSpy!
    
    //MARK: Test Lifecycle
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        interactorSpy = ArticleListInteractorSpy()
        sut = ArticleListViewController()
        sut.interactor = interactorSpy
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: "ArticleListViewControllerID") as? ArticleListViewController
        sut.loadViewIfNeeded()
    }

    func testShouldDisplayArticleList() {
        
        // Given
        let tableViewSpy = TableViewSpy()
        sut.tableView = tableViewSpy
        let articles = [Article]()
        let viewModel = ArticleList.FetchArticleList.ViewModel(articles: articles, error: nil)
        // When
        sut.displayArticleList(viewModel: viewModel)
        // Then
        XCTAssert(tableViewSpy.reloadDataCalled, "Displaying fetched articles should reload the table view")
    }
    
    func testNumberOfRowsShouldEqualNumberOfArticlesToDisplay() {
        // Given
        let tableView = sut.tableView
        let articles = getMockArticles()
        let viewModel = ArticleList.FetchArticleList.ViewModel(articles: articles, error: nil)
        sut.displayArticleList(viewModel: viewModel)
        // When
        let numberOfRows = sut.tableView(tableView!,
         numberOfRowsInSection: 20)
        // Then
        XCTAssertEqual(numberOfRows, articles?.count, "The number of tableview rows should equal the number of articles to display")
    }
    
    func testShouldConfigureTableViewCellToDisplayOrder() {
        // Given
        let tableView = sut.tableView
        let articles = getMockArticles()
        let viewModel = ArticleList.FetchArticleList.ViewModel(articles: articles, error: nil)
        sut.displayArticleList(viewModel: viewModel)
        // When
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = sut.tableView(tableView!, cellForRowAt: indexPath)
         as! ArticleListTableViewCell
        // Then
        XCTAssertEqual(cell.titleLabel?.text, "Julie Powell, Food Writer Known for ‘Julie & Julia,’ Dies at 49")
    }
    override func tearDownWithError() throws {
        sut = nil
        interactorSpy = nil
    }

    // MARK: Nil checks
    func testArticleList_TableViewShouldNotBeNil() {
        XCTAssertNotNil(sut.tableView)
    }
    
    func testArticleList_SegmentControlIsNotNil() {
        XCTAssertNotNil(sut.segmentedControl)
    }
    // MARK: DataSource
    func testDataSource_SetsTableViewDataSource() {
        XCTAssertNotNil(sut.tableView.dataSource)
        XCTAssertTrue(sut.tableView?.dataSource is ArticleListViewController)
    }
    
    // MARK: Delegate
    func testDelegate_SetsTableViewDelegate()  {
        XCTAssertNotNil(sut.tableView.delegate)
        XCTAssertTrue(sut.tableView?.delegate is ArticleListViewController)
    }
    // MARK: Action
    func testSegmentedControl_HasActionAssigned() {
        // Give
        let segmentedControl: UISegmentedControl = sut.segmentedControl
        // When
        guard let segmentedControlAction = segmentedControl.actions(forTarget: sut, forControlEvent: .valueChanged) else {
            
            XCTFail("Segmented control does not have action assigned for event .valueChanged")
            
            return
            
        }
        // Then
        XCTAssertTrue(
            segmentedControlAction.contains("indexChanged:"),
            "Segmented control should trigget indexChanged: action"
        )
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
//MARK: Interactor Spy
class ArticleListInteractorSpy: ArticleListBusinessLogic, ArticleListDataStore {
    var articles: [Article]?
    var article: Article?
    var fetchArticlesCalled = false
            
    func getSelectedArticle(_ selectedArticle: NYTimesArticles.Article?) {
        article = selectedArticle
    }
    
    func fetchArticles(numberOfDays: Int, completion: @escaping (Result<[NYTimesArticles.Article]?, NYTimesArticles.ErrorInfo>) -> ()) {
        articles = [Article]()
        fetchArticlesCalled = true
        
    }
}
class ArticleListDisplayLogicSpy: ArticleListDisplayLogic {
    var displayArticleListCalled = false
    var displayArticleViewModel: ArticleList.FetchArticleList.ViewModel?
    func displayArticleList(viewModel: NYTimesArticles.ArticleList.FetchArticleList.ViewModel) {
        displayArticleListCalled = true
        displayArticleViewModel = viewModel
    }
    
    
}

class TableViewSpy: UITableView {
    var reloadDataCalled = false
    override func reloadData() {
         reloadDataCalled = true
    }
}

