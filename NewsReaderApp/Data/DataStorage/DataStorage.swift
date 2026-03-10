//
//  DataStorage.swift
//  NewsReaderApp
//
//  Created by Tushar on 09/03/26.
//

import Foundation

final class DataStoreManager {

    static let shared = DataStoreManager()

    private let fileName = "SavedNews.plist"

    private init() {}

    private var fileURL: URL {
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documentDirectory.appendingPathComponent(fileName)
    }

    func saveArticles(_ articles: [Article]) {
        do {
            let encoder = PropertyListEncoder()
            let data = try encoder.encode(articles.map { $0.toDTO() })
            try data.write(to: fileURL)
        } catch {
            print("Error:", error)
        }
    }

    func fetchArticles() -> [Article] {
        do {
            let data = try Data(contentsOf: fileURL)
            let decoder = PropertyListDecoder()
            let codableArticles = try decoder.decode([ArticleDTO].self, from: data)

            let articles = codableArticles.map { $0.toDomain() }
            return articles
        } catch {
            print("Error", error)
            return []
        }
    }

    func saveArticle(_ article: Article) {
        var articles = fetchArticles()
        articles.append(article)
        saveArticles(articles)
    }

    func removeArticle(title: String) {
        var articles = fetchArticles()
        articles.removeAll { $0.title == title }
        saveArticles(articles)
    }

    func clearArticles() {
        try? FileManager.default.removeItem(at: fileURL)
    }
}
