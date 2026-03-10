//
//  MockSearchUseCase.swift
//  NewsReaderApp
//
//  Created by Tushar on 10/03/26.
//
@testable import NewsReaderApp
import Combine

class MockSearchNewsUseCases: SearchNewsUseCasesProtocol {

    let repository: SearchNewsRepositoryProtocol

    init(repository: SearchNewsRepositoryProtocol) {
        self.repository = repository
    }

    func searchNewsList(searchText: String) -> AnyPublisher<NewsResponse, AppNetworkErrors> {

        repository.searchNewsList(searchText: searchText)
            .map { $0.toDomain() }
            .eraseToAnyPublisher()
    }
}
