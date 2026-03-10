//
//  Artical.swift
//  NewsReaderApp
//
//  Created by Tushar on 08/03/26.
//

import Foundation

struct NewsResponse {
    let status: String
    let totalResults: Int
    let articles: [Article]
}

struct Article {
    let title: String?
    let publicationDate: String?
    let source: String?
    let imageURL: String?
    let description: String?
    let url: String?
}

struct Source {
    let name: String?
}
