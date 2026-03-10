//
//  NewsListViewController.swift
//  NewsReaderApp
//
//  Created by Tushar on 08/03/26.
//

import UIKit
import Combine

class NewsListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    private var cancellables = Set<AnyCancellable>()
    
    let viewModel: NewsListViewModelProtocol = NewsListViewViewModel(newsListUseCase: NewsListUseCases())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        viewModel.fetchNews()
        bindViewModel()
        naviagtionBarSetup()
    }
    
    private func naviagtionBarSetup() {
        self.navigationItem.title = "News"
        navigationController?.applyBlueNavigationBar()
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        registerCell()
    }
    
    func registerCell() {
        tableView.registerCell(cell: NewsListTableViewCell.self)
    }
    
    private func bindViewModel() {
        viewModel.statePublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                guard let self else { return }
                switch state {
                case .idle:
                    break
                case .loading:
                    LoaderManager.shared.showLoader(on: self.view)
                case .success:
                    LoaderManager.shared.hideLoader()
                    self.tableView.reloadData()
                case .failure(let message):
                    LoaderManager.shared.hideLoader()
                    self.showAlert(title: "Error", message: message)
                }
            }
            .store(in: &cancellables)
    }
    
}

extension NewsListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: NewsListTableViewCell = tableView.dequeueReusableCell(
            for: indexPath,
            cell: NewsListTableViewCell.self
        )
        cell.setupData(articale: viewModel.articles[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == viewModel.articles.count - 3 {
            if viewModel.isLoadMore {
                viewModel.fetchNews()
            }
        }
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

