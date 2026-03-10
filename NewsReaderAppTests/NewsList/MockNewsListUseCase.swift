//
//  MockNewsListUseCase.swift
//  NewsReaderApp
//
//  Created by Tushar on 10/03/26.
//
@testable import NewsReaderApp
import XCTest
import Combine

class MockNewsListUseCase: NewsListUseCasesProtocol {
    
    let repository: NewsListRepositoryProtocol
    
    init(repository: NewsListRepositoryProtocol) {
        self.repository = repository
    }
    
    func fetchNewsList(page: Int) -> AnyPublisher<NewsResponse, AppNetworkErrors> {
        repository.fetchNewsList(page: page)
            .map { $0.toDomain() }
            .eraseToAnyPublisher()
    }
}
