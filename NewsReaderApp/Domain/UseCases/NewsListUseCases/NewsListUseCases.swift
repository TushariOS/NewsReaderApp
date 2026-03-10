//
//  NewsListUseCases.swift
//  NewsReaderApp
//
//  Created by Tushar on 08/03/26.
//

import Foundation
import Combine

protocol NewsListUseCasesProtocol: AnyObject {
    func fetchNewsList(page: Int) -> AnyPublisher<NewsResponse, AppNetworkErrors>
}

class NewsListUseCases: NewsListUseCasesProtocol {
    let repository: NewsListRepositoryProtocol
    init(repository: NewsListRepositoryProtocol = NewsListRepositoryImplementation()) {
        self.repository = repository
    }
    
    func fetchNewsList(page: Int) -> AnyPublisher<NewsResponse, AppNetworkErrors> {
        repository.fetchNewsList(page: page)
            .map { response in
                print("response", response)
                return response.toDomain()
        }
        .eraseToAnyPublisher()
    }
}
