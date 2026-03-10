//
//  SearchNewsViewController.swift
//  NewsReaderApp
//
//  Created by Tushar on 09/03/26.
//

import UIKit
import Combine

class SearchNewsViewController: UIViewController {
    
    private let viewModel: SearchNewsViewModelProtocol = SearchNewsViewModel(searchnewsUseCase: SearchNewsUseCases())
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emptyView: UIView!

    private var cancellables = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpSearchBar()
        naviagtionBarSetup()
        setUpTableView()
        bindViewModel()
    }
    
    private func setUpSearchBar() {
        self.searchBar.delegate = self
    }
    
    private func naviagtionBarSetup() {
        self.navigationItem.title = "Search"
        navigationController?.applyBlueNavigationBar()
    }
    
    private func setUpTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.registerCell()
    }
    
    func registerCell() {
        tableView.registerCell(cell: NewsListTableViewCell.self)
    }
    
    private func bindViewModel() {
        viewModel.articlesPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] value in
                if value.isEmpty {
                    self?.emptyView.isHidden = false
                } else {
                    self?.emptyView.isHidden = true
                }
                self?.tableView.reloadData()
            }
            .store(in: &cancellables)
    }

}

extension SearchNewsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            viewModel.clearArticles()
        } else {
            viewModel.fetchNews(with: searchText)
        }
    }
}

extension SearchNewsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: NewsListTableViewCell = tableView.dequeueReusableCell(
            for: indexPath, cell: NewsListTableViewCell.self
        )
        cell.setupData(articale: viewModel.articles[indexPath.row])
        return cell
    }
        
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 190.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let article = viewModel.articles[indexPath.row]

        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        guard let vc = storyboard.instantiateViewController(
            withIdentifier: "NewsDetailsViewController"
        ) as? NewsDetailsViewController else { return }

        vc.article = article

        navigationController?.pushViewController(vc, animated: true)
    }
}

