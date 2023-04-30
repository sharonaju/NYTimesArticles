//
//  ArticleDetailTitleTableViewCell.swift
//  NYTimesArticles
//
//  Created by Sharon Varghese on 30/04/2023.
//

import UIKit

class ArticleDetailTitleTableViewCell: UITableViewCell {

    static let reuseIdentifier = "ArticleDetailTitleTableViewCellID"
    @IBOutlet var titleLabel: UILabel!
    var data: ArticleDetail.ArticleItem.ViewModel.ArticleTitleModel? {
        didSet {
            loadData()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func loadData() {
        titleLabel.text = data?.title ?? ""
    }
    
}
