//
//  NewsListViewModel.swift
//  NewsReaderApp
//
//  Created by Tushar on 08/03/26.
//

import Foundation
import Combine

protocol NewsListViewModelProtocol: AnyObject {
    var isLoadMore: Bool { get set}
    var articles: [Article] { get }
    var statePublisher: AnyPublisher<ViewState, Never> { get }
    func fetchNews()
}

class NewsListViewViewModel: NewsListViewModelProtocol {
    private var cancellables = Set<AnyCancellable>()
    private var page = 1
    var isLoadMore: Bool = true
    
    @Published var articles: [Article] = []
    @Published private(set) var state: ViewState = .idle
    var statePublisher: AnyPublisher<ViewState, Never> {
        $state.eraseToAnyPublisher()
    }
    
    let newsListUseCase: NewsListUseCasesProtocol
    init(newsListUseCase: NewsListUseCasesProtocol) {
        self.newsListUseCase = newsListUseCase
    }
 
    func fetchNews() {
        state = .loading
        newsListUseCase.fetchNewsList(page: page)
            .sink {[weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.state = .failure(error.localizedDescription)
                case .finished:
                    self?.state = .idle
                }
            } receiveValue: {[weak self] response in
                if response.articles.isEmpty {
                    self?.isLoadMore = false
                    self?.state = .success(self?.articles ?? [])
                    return
                }
                self?.articles.append(contentsOf: response.articles)
                self?.page += 1
                self?.state = .success(self?.articles ?? [])
            }.store(in: &cancellables)
    }
}
