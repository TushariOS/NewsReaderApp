//
//  ViewState.swift
//  NewsReaderApp
//
//  Created by Tushar on 10/03/26.
//
import Foundation

enum ViewState {
    case idle
    case loading
    case success([Article])
    case failure(String)
}
