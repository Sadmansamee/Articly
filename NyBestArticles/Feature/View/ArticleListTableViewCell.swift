//
//  ArticleListTableViewCell.swift
//  NyBestArticles
//
//  Created by sadman samee on 11/15/19.
//  Copyright © 2019 Sadman Samee. All rights reserved.
//

import Kingfisher
import UIKit

class ArticleListTableViewCell: UITableViewCell {
    @IBOutlet var labelTitle: UILabel!
    @IBOutlet var labelAbstract: UILabel!
    @IBOutlet var labelPublishDate: UILabel!
    @IBOutlet var imgView: UIImageView!
    @IBOutlet var labelByLine: UILabel!

    var articleViewModel: ArticleViewModel? {
        didSet {
            bindViewModel()
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

    private func bindViewModel() {
        if let viewModel = articleViewModel {
            labelTitle.text = viewModel.titleVM
            labelAbstract.text = viewModel.abstractVM
            labelByLine.text = viewModel.bylineVM
            labelPublishDate.text = "on " + viewModel.publishedDateVM
            imgView.kf.indicatorType = .activity
            imgView.kf.setImage(with: URL(string: viewModel.smallImageVM), placeholder: #imageLiteral(resourceName: "placeholder"))
        }
    }
}
