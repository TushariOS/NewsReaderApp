//
//  MockNewsListRepositoty.swift
//  NewsReaderApp
//
//  Created by Tushar on 10/03/26.


@testable import NewsReaderApp
import Combine

class MockNewsListRepository: NewsListRepositoryProtocol {
    
    var shouldReturnError = false
    
    func fetchNewsList(page: Int) -> AnyPublisher<NewsResponseDTO, AppNetworkErrors> {
        
        if shouldReturnError {
            return Fail(error: AppNetworkErrors.unownkonError)
                .eraseToAnyPublisher()
        }
        
        let articleDTO = ArticleDTO(
            source: SourceDTO(id: "1", name: "Test"),
            author: "Test Author",
            title: "Test Title",
            description: "Test Description",
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
