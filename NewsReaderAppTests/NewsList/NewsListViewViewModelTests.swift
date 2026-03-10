//
//  NewsListViewViewModelTests.swift
//  NewsReaderApp
//
//  Created by Tushar on 10/03/26.
//

@testable import NewsReaderApp
import Combine
import XCTest

final class NewsListViewViewModelTests: XCTestCase {
    
    var viewModel: NewsListViewViewModel!
    var mockRepository: MockNewsListRepository!
    var mockUseCase: MockNewsListUseCase!
    
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        mockRepository = MockNewsListRepository()
        mockUseCase = MockNewsListUseCase(repository: mockRepository)
        viewModel = NewsListViewViewModel(newsListUseCase: mockUseCase)
        cancellables = []
    }
    
    override func tearDown() {
        viewModel = nil
        mockRepository = nil
        cancellables = nil
        super.tearDown()
    }
    
    func testFetchNewsListSuccess() {
        let expectation = XCTestExpectation(description: "Fetch news list")
            mockUseCase.fetchNewsList(page: 1)
                .sink { completion in
                } receiveValue: { response in
                    XCTAssertEqual(response.articles.count, 1)
                    XCTAssertEqual(response.articles.first?.title, "Test Title")
                    XCTAssertEqual(response.articles.first?.publicationDate, "2026-03-10T01:13:42Z")
                    expectation.fulfill()
                }
                .store(in: &cancellables)

            wait(for: [expectation], timeout: 2)
    }
    
    func testFetchNewsListFailure() {
        mockRepository.shouldReturnError = true
        let expectation = XCTestExpectation(description: "Fetch news list")
        mockUseCase.fetchNewsList(page: 1)
               .sink { completion in
                   switch completion {
                   case .failure(let error):
                       XCTAssertEqual(error, AppNetworkErrors.unownkonError)
                       expectation.fulfill()
                   case .finished:
                       XCTFail("Expected failure but got finished")
                   }
               } receiveValue: { _ in
                   XCTFail("Expected failure but received value")
               }
               .store(in: &cancellables)
           wait(for: [expectation], timeout: 3)
    }
}
