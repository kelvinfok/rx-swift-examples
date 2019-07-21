//
//  ViewController.swift
//  News
//
//  Created by Kelvin Fok on 17/7/19.
//  Copyright © 2019 Kelvin Fok. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class NewsTableViewController: UITableViewController {
    
    private let API_KEY = "6bd41cf1ebd74fb2be44bebee5f06506"
    private let disposeBag = DisposeBag()
    
    private var articles = [Article]() {
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
        
        let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=6bd41cf1ebd74fb2be44bebee5f06506")!
        
//        Observable.just(url)
//            .flatMap { (url) -> Observable<Data> in
//                let request = URLRequest(url: url)
//                return URLSession.shared.rx.data(request: request)
//            }.map { (data) -> [Article]? in
//                return try? JSONDecoder().decode(ArticlesList.self, from: data).articles
//            }.subscribe(onNext: { articles in
//                if let articles = articles {
//                    self.articles = articles
//                }
//            }).disposed(by: disposeBag)
        
        let resource = Resource<ArticlesList>.init(url: url)
        
        URLRequest.load(resource: ArticlesList.all)
            .subscribe(onNext: { result in
                if let result = result {
                    print("resu: \(result)")
                    self.articles = result.articles
                }
            }).disposed(by: disposeBag)
        
        
    }
}

extension NewsTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let article = self.articles[indexPath.item]
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        cell.textLabel?.text = article.title
        cell.detailTextLabel?.text = article.description
        return cell
    }
}
