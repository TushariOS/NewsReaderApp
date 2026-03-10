//
//  Untitled.swift
//  NewsReaderApp
//
//  Created by Tushar on 10/03/26.
//
@testable import NewsReaderApp
import Combine

class MockSearchRepository: SearchNewsRepositoryProtocol {

    var shouldReturnError = false

    func searchNewsList(searchText: String) -> AnyPublisher<NewsResponseDTO, AppNetworkErrors> {

        if shouldReturnError {
            return Fail(error: AppNetworkErrors.unownkonError)
                .eraseToAnyPublisher()
        }

        let articleDTO = ArticleDTO(
            source: SourceDTO(id: "1", name: "Test"),
            author: "Tester",
            title: "Search Result",
            description: "Search Description",
            url: "https://test.com",
            urlToImage: nil,
            publishedAt: "2026-03-10T01:13:42Z",
            content: "Test Content"
        )

        let responseDTO = NewsResponseDTO(
            status: "ok",
            totalResults: 1,
            articles: [articleDTO]
        )

        return Just(responseDTO)
            .setFailureType(to: AppNetworkErrors.self)
            .eraseToAnyPublisher()
    }
}
