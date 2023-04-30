//
//  ArticleDetailPresenter.swift
//  NYTimesArticles
//
//  Created by Sharon Varghese on 30/04/2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol ArticleDetailPresentationLogic
{
    func presentSelectedArticle(response: ArticleDetail.ArticleItem.Response)
}

class ArticleDetailPresenter: ArticleDetailPresentationLogic
{
  weak var viewController: ArticleDetailDisplayLogic?
  
    // MARK: Present Selected Article
  
  func presentSelectedArticle(response: ArticleDetail.ArticleItem.Response)
    {
        var articleDetails = [Any]()
        let title = ArticleDetail.ArticleItem.ViewModel.ArticleTitleModel(title: response.article?.title)
        articleDetails.append(title)
        
        let mediaMetaData = response.article?.media?.first?.mediaMetadata?.filter{ $0.format == .mediumThreeByTwo440 }
        let imageURL = mediaMetaData?.first?.url
        let image = ArticleDetail.ArticleItem.ViewModel.ArticleImageModel(imageURLString: imageURL)
        articleDetails.append(image)
        
        let date = response.article?.updated?.dateFormatted
        let authorDetails = ArticleDetail.ArticleItem.ViewModel.ArticleAuthorAndDateModel(author: response.article?.byline, date: date)
        articleDetails.append(authorDetails)
        
        let articleDescription = ArticleDetail.ArticleItem.ViewModel.ArticleDescriptionModel(description: response.article?.abstract)
        articleDetails.append(articleDescription)
        
        viewController?.displayArticle(detail: articleDetails)
        
    }
}