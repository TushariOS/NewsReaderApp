//
//  SearchNewsViewModel.swift
//  NewsReaderApp
//
//  Created by Tushar on 09/03/26.
//

import Foundation
import Combine

protocol SearchNewsViewModelProtocol: AnyObject {
    var articles: [Article] { get }
    var articlesPublisher: AnyPublisher<[Article], Never> { get }
    func fetchNews(with searchText: String?)
    func clearArticles()
}

class SearchNewsViewModel: SearchNewsViewModelProtocol {
    
    private var cancellables = Set<AnyCancellable>()
    private var isLoading: Bool = false
    
    @Published var articles: [Article] = []
    private var searchWorkItem: DispatchWorkItem?

    var articlesPublisher: AnyPublisher<[Article], Never> {
        $articles.eraseToAnyPublisher()
    }
    
    let searchnewsUseCase: SearchNewsUseCasesProtocol
    
    init(searchnewsUseCase: SearchNewsUseCasesProtocol) {
        self.searchnewsUseCase = searchnewsUseCase
    }
    
    func fetchNews(with searchText: String? = nil) {
        let text = searchText ?? ""

        searchWorkItem?.cancel()

        let workItem = DispatchWorkItem { [weak self] in
            guard let self else { return }
            self.isLoading = true
            searchAPICall(text)
        }
        
        searchWorkItem = workItem
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: workItem)
    }
    
    private func searchAPICall(_ text: String) {
        self.searchnewsUseCase.searchNewsList(searchText: text)
            .sink { [weak self] completion in
                self?.isLoading = false
                switch completion {
                case .failure(let error):
                    print("Error:", error)
                case .finished:
                    print("Finished")
                }
            } receiveValue: { [weak self] response in
                guard let self else { return }
                print("count---", response.articles.count)
                self.articles = response.articles
            }
            .store(in: &self.cancellables)
    }

    func clearArticles() {
         articles.removeAll()
    }
}
