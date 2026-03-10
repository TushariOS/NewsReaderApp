//
//  NewsListUseCases.swift
//  NewsReaderApp
//
//  Created by Tushar on 08/03/26.
//

import Foundation
import Combine

protocol SearchNewsUseCasesProtocol: AnyObject {
    func searchNewsList(searchText: String) -> AnyPublisher<NewsResponse, AppNetworkErrors>
}

class SearchNewsUseCases: SearchNewsUseCasesProtocol {
    let repository: SearchNewsRepositoryProtocol
    init(repository: SearchNewsRepositoryProtocol = SearchNewsRepositoryImplementation()) {
        self.repository = repository
    }
    
    func searchNewsList(searchText: String) -> AnyPublisher<NewsResponse, AppNetworkErrors> {
        repository.searchNewsList(searchText: searchText)
            .map { response in
                print("response", response)
                return response.toDomain()
        }
        .eraseToAnyPublisher()
    }
}
