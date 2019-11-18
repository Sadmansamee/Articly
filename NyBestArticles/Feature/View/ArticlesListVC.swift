//
//  ArticlesListViewController.swift
//  NyBestArticles
//
//  Created by sadman samee on 11/14/19.
//  Copyright © 2019 Sadman Samee. All rights reserved.
//

import Reachability
import RxCocoa
import RxSwift
import UIKit

protocol ArticlesListVCProtocol: AnyObject {
    var onArticleSelected: ((ArticleViewModel) -> Void)? { get set }
}

class ArticlesListVC: UIViewController, HomeStoryboardLoadable, ArticlesListVCProtocol {
    var onArticleSelected: ((ArticleViewModel) -> Void)?

    var articlesListViewModel: ArticlesListViewModel!
    private var disposeBag = DisposeBag()
    private var reachability: Reachability?

    @IBOutlet var tableView: UITableView!
    private var loadingView: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Articly"
        initLoadingView()
        setUpTableView()
        setTableViewModel()
        setReachablity()
        viewModelCallbacks()
    }

    deinit {
        reachability?.stopNotifier()
        reachability = nil
    }

    private func setReachablity() {
        reachability = try? Reachability()

        reachability?.whenReachable = { [weak self] _ in
            guard let self = self else {
                return
            }
            self.articlesListViewModel.updateRechablity(rechable: true)
        }
        reachability?.whenUnreachable = { [weak self] _ in
            guard let self = self else {
                return
            }
            self.articlesListViewModel.updateRechablity(rechable: false)
        }
        do {
            try reachability?.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }

    // MARK: - UI

    private func initLoadingView() {
        if #available(iOS 13.0, *) {
            loadingView = UIActivityIndicatorView(style: .large)
        } else {
            // Fallback on earlier versions
            loadingView = UIActivityIndicatorView(style: .gray)
        }

        loadingView = UIActivityIndicatorView(style: .gray)
        loadingView.startAnimating()
        loadingView.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: view.bounds.width, height: CGFloat(70))
        loadingView.center = view.center
        loadingView.hidesWhenStopped = true
        view.addSubview(loadingView)
    }

    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        present(alert, animated: true)
    }
}

// MARK: - View Model

extension ArticlesListVC {
    private func viewModelCallbacks() {
        articlesListViewModel.onAlertMessage
            .map { [weak self] in

                guard let self = self else {
                    return
                }
                self.showAlert(title: $0.title ?? "", message: $0.message ?? "")
            }.subscribe()
            .disposed(by: disposeBag)

        articlesListViewModel.onLoading
            .map { [weak self] isLoading in

                guard let self = self else {
                    return
                }

                if isLoading {
                    self.loadingView.startAnimating()
                } else {
                    self.loadingView.stopAnimating()
                }
            }
            .subscribe()
            .disposed(by: disposeBag)
    }
}

// MARK: - TableView

extension ArticlesListVC {
    // MARK: - View Model TableView

    private func setTableViewModel() {
        // setting delegate
        tableView.rx.setDelegate(self)
            .disposed(by: disposeBag)

        // when cell is selected
        tableView.rx
            .modelSelected(ArticleViewModel.self)
            .subscribe(
                onNext: { [weak self] item in
                    guard let self = self else {
                        return
                    }
                    if let selectedRowIndexPath = self.tableView.indexPathForSelectedRow {
                        self.tableView?.deselectRow(at: selectedRowIndexPath, animated: true)
                        self.onArticleSelected?(item)
                    }
                }
            )
            .disposed(by: disposeBag)

        articlesListViewModel.onMostViwedArticleViewModels.bind(to: tableView.rx.items) { tableView, _, element in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ArticleListTableViewCell.id)
                as? ArticleListTableViewCell else {
                return UITableViewCell()
            }
            cell.articleViewModel = element
            return cell
        }.disposed(by: disposeBag)
    }

    private func setUpTableView() {
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.register(ArticleListTableViewCell.nib, forCellReuseIdentifier: ArticleListTableViewCell.id)
    }
}

extension ArticlesListVC: UITableViewDelegate {
    func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        200
    }
}
