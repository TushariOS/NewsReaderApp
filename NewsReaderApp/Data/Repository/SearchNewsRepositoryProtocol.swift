//
//  NewsListRepositoryProtocol.swift
//  NewsReaderApp
//
//  Created by Tushar on 08/03/26.
//

import Foundation
import Combine

protocol SearchNewsRepositoryProtocol {
    func searchNewsList(searchText: String) -> AnyPublisher<NewsResponseDTO, AppNetworkErrors>
}
