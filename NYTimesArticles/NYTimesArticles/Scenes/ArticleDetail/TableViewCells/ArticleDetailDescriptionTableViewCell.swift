//
//  ArticleDetailDescriptionTableViewCell.swift
//  NYTimesArticles
//
//  Created by Sharon Varghese on 30/04/2023.
//

import UIKit

class ArticleDetailDescriptionTableViewCell: UITableViewCell {

    static let reuseIdentifier = "ArticleDetailDescriptionTableViewCellID"
    @IBOutlet var descriptionLabel: UILabel!
    var data: ArticleDetail.ArticleItem.ViewModel.ArticleDescriptionModel? {
        didSet {
            assignDescription()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func assignDescription() {
        descriptionLabel.text = data?.description ?? ""
    }
    
}
