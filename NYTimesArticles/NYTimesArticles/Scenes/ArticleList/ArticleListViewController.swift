//
//  ArticleListViewController.swift
//  NYTimesArticles
//
//  Created by Sharon Varghese on 29/04/2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit
import SkeletonView

protocol ArticleListDisplayLogic: AnyObject
{
    func displayArticleList(viewModel: ArticleList.FetchArticleList.ViewModel)
}

class ArticleListViewController: UIViewController, ArticleListDisplayLogic
{
  
    // MARK: @IBOutlet
    @IBOutlet var tableView: UITableView!
    @IBOutlet var segmentedControl: UISegmentedControl!
    
    // MARK: Properties
    var interactor: ArticleListBusinessLogic?
    var router: (NSObjectProtocol & ArticleListRoutingLogic & ArticleListDataPassing)?
    var articles: [Article]?
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
    {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        setup()
    }
    // MARK: View lifecycle
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        prepareNavigationBar()
        prepareSegmentControl()
        prepareTableView()
        loadArticles(numberOfDays: 1)
    }
    
    // MARK: Setup
    
    private func setup()
    {
        let viewController = self
        let interactor = ArticleListInteractor()
        let presenter = ArticleListPresenter()
        let router = ArticleListRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: Routing
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
    
    // MARK: Prepare UI
      
    func prepareTableView()  {
        tableView.accessibilityIdentifier = "ArticleListTableView"
        tableView.register(UINib(nibName: "ArticleListTableViewCell", bundle: nil), forCellReuseIdentifier: ArticleListTableViewCell.reuseIdentifier)
        tableView.estimatedRowHeight = 150
    }
    
    func prepareNavigationBar() {
        self.title = "Popular Articles"
        navigationController?.navigationBar.prefersLargeTitles = true
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .black
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont(name: "TimesNewRomanPS-BoldMT", size: 34)!]
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    func prepareSegmentControl() {
        let font = UIFont(name: "TimesNewRomanPSMT", size: 14)!
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.font: font], for: .normal)
    }
    
    func loadArticles(numberOfDays: Int)
    {
        self.tableView.showAnimatedGradientSkeleton()
        interactor?.fetchArticles(numberOfDays: numberOfDays, completion: { result in
            self.tableView.hideSkeleton()
            
        })

    }
    // MARK: ArticleListDisplayLogic
    func displayArticleList(viewModel: ArticleList.FetchArticleList.ViewModel)
    {
        if let articles = viewModel.articles {
            self.articles = articles
            self.tableView.reloadData()
        } else {
            print("Error \(viewModel.error?.body ?? "")")
        }
        
    }
    
    @IBAction func indexChanged(_ sender: Any) {
        switch segmentedControl.selectedSegmentIndex
        {
        case 0:
            loadArticles(numberOfDays: 1)
        case 1:
            loadArticles(numberOfDays: 7)
        case 2:
            loadArticles(numberOfDays: 30)
        default:
            break
        }
    }

}
// MARK: Table View Data source
extension ArticleListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ArticleListTableViewCell.reuseIdentifier, for: indexPath) as! ArticleListTableViewCell
        let article = articles?[indexPath.row]
        cell.data = article
        return cell
    }
    
}

// MARK: Table View Delegate
extension ArticleListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            interactor?.getSelectedArticle(articles?[indexPath.row])
            router?.routeToArticleDetail(segue: nil)
        
    }
}

// MARK: SkeletonTableViewDataSource

extension ArticleListViewController: SkeletonTableViewDataSource {
    func collectionSkeletonView(_ skeletonView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return ArticleListTableViewCell.reuseIdentifier
    }

}
