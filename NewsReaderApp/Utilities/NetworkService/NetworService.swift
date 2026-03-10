//
//  NetworService.swift
//  NewsReaderApp
//
//  Created by Tushar on 08/03/26.
//
import Foundation
import Combine

final class NetworKService {
    
    static let shared = NetworKService()
    
    private init() {}
    
    func request<T: Decodable>(request: URLRequest) -> AnyPublisher<T, AppNetworkErrors> {
        URLSession.shared.dataTaskPublisher(for: request)
            .tryMap({ (data, response) in
                guard let response = response as? HTTPURLResponse else {
                    throw AppNetworkErrors.invalidResponse
                }
                
                switch response.statusCode {
                case 200...299:
                    return data
                case 400...499:
                    throw AppNetworkErrors.clientError
                case 500...599:
                    throw AppNetworkErrors.serverError
                default:
                    throw AppNetworkErrors.unownkonError
                }
            })
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError({ error in
                if let networkError = error as? AppNetworkErrors {
                    return networkError
                }
                
                if error is DecodingError {
                    return .decodingError
                }
                
                return .unownkonError
            })
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
