//
//  ArticleListTableViewCell.swift
//  NyBestArticles
//
//  Created by sadman samee on 11/15/19.
//  Copyright © 2019 Sadman Samee. All rights reserved.
//

import UIKit

class ArticleListTableViewCell: UITableViewCell {
    @IBOutlet var labelTitle: UILabel!
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
        if let vm = articleViewModel {
            labelTitle.text = vm.titleVM
        }
    }
}
