//
//  Untitled.swift
//  NewsReaderApp
//
//  Created by Tushar on 08/03/26.
//

import Foundation

struct NewsResponseDTO: Codable {
    let status: String?
    let totalResults: Int?
    let articles: [ArticleDTO]?
    
    enum codingKeys: String, CodingKey {
        case status, totalResults, articles
    }
}

struct ArticleDTO: Codable {
    let source: SourceDTO?
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
}

struct SourceDTO: Codable {
    let id: String?
    let name: String?
}
