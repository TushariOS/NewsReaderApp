//
//  NewsListRepositoryImplementation.swift
//  NewsReaderApp
//
//  Created by Tushar on 08/03/26.
//

import Foundation
import Combine

class NewsListRepositoryImplementation: NewsListRepositoryProtocol {
    
    let networkService = NetworKService.shared
    
    func fetchNewsList(page: Int) -> AnyPublisher<NewsResponseDTO, AppNetworkErrors> {
//        guard let url = Bundle.main.url(forResource: "DummaryNewsResponse", withExtension: "json") else {
//            return Fail(error: .unownkonError).eraseToAnyPublisher()
//        }
//
//        do {
//            let data = try Data(contentsOf: url)
//            let response = try JSONDecoder().decode(NewsResponseDTO.self, from: data)
//
//            return Just(response)
//                .setFailureType(to: AppNetworkErrors.self)
//                .eraseToAnyPublisher()
//
//        } catch {
//            return Fail(error: .unownkonError)
//                .eraseToAnyPublisher()
//        }
        if let request = buildNewsRequest(page: page) {
            return networkService.request(request: request)
        }
        return Fail(error: .unownkonError)
            .eraseToAnyPublisher()
    }
    
    func buildNewsRequest(page: Int) -> URLRequest? {
        var components = URLComponents()
        components.scheme = APIConfig.scheme
        components.host = APIConfig.host
        components.path = APIConfig.headlinePath
        components.queryItems = [
            URLQueryItem(name: "country", value: "us"),
            URLQueryItem(name: "page", value: "\(page)"),
            URLQueryItem(name: "apiKey", value: APIConfig.apiKey)
        ]
        
        guard let url = components.url else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        return request
    }

}

struct APIConfig {
    static let scheme = "https"
    static let host = "newsapi.org"
    static let headlinePath = "/v2/top-headlines"
    static let apiKey = "913cfb63f8094d2ca10e013716c8bb26"
    static let everythingPath = "/v2/everything"
}
