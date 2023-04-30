//
//  ArticleDetailDateTableViewCell.swift
//  NYTimesArticles
//
//  Created by Sharon Varghese on 30/04/2023.
//

import UIKit

class ArticleDetailDateTableViewCell: UITableViewCell {

    static let reuseIdentifier = "ArticleDetailDateTableViewCellID"
    @IBOutlet var byLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    var data: ArticleDetail.ArticleItem.ViewModel.ArticleAuthorAndDateModel? {
        didSet {
            loadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func loadData() {
        dateLabel.text = data?.date
        byLabel.text = data?.author
    }
    
}
