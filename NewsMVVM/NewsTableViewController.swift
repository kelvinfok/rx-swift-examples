//
//  ViewController.swift
//  NewsMVVM
//
//  Created by Kelvin Fok on 21/7/19.
//  Copyright © 2019 Kelvin Fok. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class NewsTableViewController: UITableViewController {
    
    private let disposeBag = DisposeBag()
    
    private var articleListViewModel: ArticleListViewModel! {
        didSet {
            OperationQueue.main.addOperation {
                self.tableView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        populateNews()
    }

    private func populateNews() {
        URLRequest.load(resource: ArticlesList.all)
            .subscribe(onNext: { articleResponse in
                if let articles = articleResponse?.articles {
                    self.articleListViewModel = ArticleListViewModel(articles)
                }
            }).disposed(by: disposeBag)
    }
}

extension NewsTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articleListViewModel == nil ? 0 : self.articleListViewModel.articlesVM.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        let articleViewModel = articleListViewModel.articleAt(indexPath.item)
        
        // Driver
        articleViewModel.description.asDriver(onErrorJustReturn: "")
            .drive(cell.detailTextLabel!.rx.text)
            .disposed(by: disposeBag)
        
        articleViewModel.title.asDriver(onErrorJustReturn: "")
            .drive(cell.textLabel!.rx.text)
            .disposed(by: disposeBag)
            
        return cell
    }
}
