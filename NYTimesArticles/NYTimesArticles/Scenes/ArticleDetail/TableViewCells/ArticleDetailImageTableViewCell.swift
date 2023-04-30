//
//  ArticleDetailImageTableViewCell.swift
//  NYTimesArticles
//
//  Created by Sharon Varghese on 30/04/2023.
//

import UIKit

class ArticleDetailImageTableViewCell: UITableViewCell {

    static let reuseIdentifier = "ArticleDetailImageTableViewCellID"
    @IBOutlet var articleImageView: UIImageView!
    var data: ArticleDetail.ArticleItem.ViewModel.ArticleImageModel? {
        didSet {
            loadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        prepareImageView()
    }
    
    func prepareImageView() {
        articleImageView.layer.cornerRadius = 5
    }
    
    func loadData() {
        if let imageURL = URL(string: data?.imageURLString ?? "") {
            articleImageView.sd_setImage(with: imageURL)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
