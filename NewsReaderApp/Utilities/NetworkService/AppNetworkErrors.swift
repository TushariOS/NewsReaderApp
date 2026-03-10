//
//  AppErrors.swift
//  NewsReaderApp
//
//  Created by Tushar on 08/03/26.
//

enum AppNetworkErrors : Error {
    case invalidResponse
    case clientError
    case serverError
    case decodingError
    case invalidURL
    case unownkonError
}
