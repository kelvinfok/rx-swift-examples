//
//  Article.swift
//  News
//
//  Created by Kelvin Fok on 17/7/19.
//  Copyright © 2019 Kelvin Fok. All rights reserved.
//

import Foundation

struct Article: Decodable {
    let title: String
    let description: String
}

struct ArticlesList: Decodable {
    var articles: [Article]
}

extension ArticlesList {
    
    static var all: Resource<ArticlesList> = {
       let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=6bd41cf1ebd74fb2be44bebee5f06506")!
        return Resource(url: url)
    }()
    
    
}
