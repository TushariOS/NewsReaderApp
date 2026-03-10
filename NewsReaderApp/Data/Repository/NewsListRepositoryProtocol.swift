//
//  NewsListRepositoryProtocol.swift
//  NewsReaderApp
//
//  Created by Tushar on 08/03/26.
//

import Foundation
import Combine

protocol NewsListRepositoryProtocol {
    func fetchNewsList(page: Int) -> AnyPublisher<NewsResponseDTO, AppNetworkErrors>
}
