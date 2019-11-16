//
//  ArticleDetailViewController.swift
//  NyBestArticles
//
//  Created by sadman samee on 11/16/19.
//  Copyright © 2019 Sadman Samee. All rights reserved.
//

import Kingfisher
import RxSwift
import UIKit

class ArticleDetailVC: UITableViewController, HomeStoryboardLoadable {
    // MARK: - Properties

    private var disposeBag = DisposeBag()
    var articleViewModel: ArticleViewModel?

    // MARK: - UI Properties

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var labelTitle: UILabel!
    @IBOutlet var labelByLine: UILabel!
    @IBOutlet var labelPublishDate: UILabel!
    @IBOutlet var labelAbstract: UILabel!
    @IBOutlet var buttonReadFullStory: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setUIProperties()
    }
    
    private func setUI(){
    }

    private func setUIProperties() {
        if let viewModel = articleViewModel {
            imageView.kf.indicatorType = .activity
            imageView.kf.setImage(with: URL(string: viewModel.largeImageVM), placeholder: #imageLiteral(resourceName: "placeholder"))
            labelTitle.text = viewModel.titleVM
            labelAbstract.text = viewModel.abstractVM
            labelByLine.text = viewModel.bylineVM
            labelPublishDate.text = "Published on " + viewModel.publishedDateVM
        }
    }

    // MARK: - Actions

    @IBAction func actionReadFullStory(_: Any) {
        guard let viewmodel = articleViewModel, let url = URL(string: viewmodel.urlVM) else { return }
        UIApplication.shared.open(url)
    }
}
