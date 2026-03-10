//
//  NewsListRepositoryImplementation.swift
//  NewsReaderApp
//
//  Created by Tushar on 08/03/26.
//

import Foundation
import Combine

class SearchNewsRepositoryImplementation: SearchNewsRepositoryProtocol {
    
    
    let networkService = NetworKService.shared
    
    func searchNewsList(searchText: String) -> AnyPublisher<NewsResponseDTO, AppNetworkErrors> {
        
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

        if let request = buildNewsRequest(searchText: searchText) {
            return networkService.request(request: request)
        }
        return Fail(error: .unownkonError)
            .eraseToAnyPublisher()
    }
    
    func buildNewsRequest(searchText: String) -> URLRequest? {
        var components = URLComponents()
        components.scheme = APIConfig.scheme
        components.host = APIConfig.host
        components.path = APIConfig.everythingPath
        components.queryItems = [
            URLQueryItem(name: "q", value: searchText),
           // URLQueryItem(name: "from", value: "2026-03-09"),
            URLQueryItem(name: "sortBy", value: "popularity"),
            URLQueryItem(name: "apiKey", value: APIConfig.apiKey)
        ]
        
        guard let url = components.url else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        print("Request:", request)
        return request
    }
}
