//
//  Untitled.swift
//  NewsReaderApp
//
//  Created by Tushar on 10/03/26.
//

@testable import NewsReaderApp
import XCTest
import Combine

final class SearchNewsViewModelTests: XCTestCase {

    var viewModel: SearchNewsViewModel!
    var mockRepository: MockSearchRepository!
    var mockUseCase: MockSearchNewsUseCases!
    
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()

        mockRepository = MockSearchRepository()
        mockUseCase = MockSearchNewsUseCases(repository: mockRepository)
        viewModel = SearchNewsViewModel(searchnewsUseCase: mockUseCase)

        cancellables = []
    }

    override func tearDown() {
        viewModel = nil
        mockRepository = nil
        cancellables = nil

        super.tearDown()
    }
    
    func testSearchNewsSuccess() {
        let expectation = XCTestExpectation(description: "Search success")
        mockUseCase.searchNewsList(searchText: "Apple")
            .sink { completion in
            } receiveValue: { response in
                XCTAssertEqual(response.articles.count, 1)
                XCTAssertEqual(response.articles.first?.title, "Search Result")
                XCTAssertEqual(response.articles.first?.publicationDate, "2026-03-10T01:13:42Z")
                expectation.fulfill()
            }
            .store(in: &cancellables)
        wait(for: [expectation], timeout: 5)
    }
    
    func testSearchNewsFailure() {
        mockRepository.shouldReturnError = true
        let expectation = XCTestExpectation(description: "Search failure")
        mockUseCase.searchNewsList(searchText: "Apple")
            .sink { completion in
                switch completion {
                case .failure(let error):
                    XCTAssertEqual(error, AppNetworkErrors.unownkonError)
                    expectation.fulfill()
                case .finished:
                    XCTFail("failure")
                }
            } receiveValue: { _ in
                XCTFail("not receive value")
            }
            .store(in: &cancellables)
        wait(for: [expectation], timeout: 3)
    }
}
