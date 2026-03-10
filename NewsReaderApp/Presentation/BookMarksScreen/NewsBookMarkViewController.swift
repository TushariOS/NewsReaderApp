//
//  NewsBookMarkViewController.swift
//  NewsReaderApp
//
//  Created by Tushar on 09/03/26.
//

import UIKit
import Combine

final class NewsBookMarkViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    private var articles: [Article] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        naviagtionBarSetup()
        articles = DataStoreManager.shared.fetchArticles()
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(upadteTableView),
            name: .didAddArticle,
            object: nil
        )
    }
    
    //MARK: - private
    private func naviagtionBarSetup() {
        self.navigationItem.title = "BookMark's"
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
    
    @objc func upadteTableView() {
        articles.removeAll()
        articles = DataStoreManager.shared.fetchArticles()
        tableView.reloadData()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

//MARK: - UITableViewDataSource, UITableViewDelegate
extension NewsBookMarkViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: NewsListTableViewCell = tableView.dequeueReusableCell(
            for: indexPath,
            cell: NewsListTableViewCell.self
        )
        cell.setupData(articale: articles[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 190.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let article = articles[indexPath.row]
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        guard let vc = storyboard.instantiateViewController(
            withIdentifier: "NewsDetailsViewController"
        ) as? NewsDetailsViewController else { return }
        
        vc.article = article
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath)
    -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive,
                                              title: "Delete") { [weak self] _, _, completion in
            
            DataStoreManager.shared.removeArticle(title: self?.articles[indexPath.row].title ?? "")
            self?.articles.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            completion(true)
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}

