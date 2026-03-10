//
//  NewsDetailsViewController.swift
//  NewsReaderApp
//
//  Created by Tushar on 09/03/26.
//

import UIKit
import SafariServices
import SDWebImage

final class NewsDetailsViewController: UIViewController {
    
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var newsTitleLabel: UILabel!
    @IBOutlet weak var newsContentLabel: UILabel!
    @IBOutlet weak var newsPublishedAtLabel: UILabel!
    
    var article: Article?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpData()
    }
    
   private func setUpData() {
        guard let article = article else { return }
        newsTitleLabel.text = article.title
        newsPublishedAtLabel.text = article.publicationDate?.toDisplayDate()
        newsContentLabel.text = article.description
        
        if let urlString = article.imageURL {
            newsImageView.sd_setImage(
                with: URL(string: urlString),
                placeholderImage: UIImage(systemName: "photo")
            )
        }
    }
    
    //MARK: - IBAction
    @IBAction func addToBookMark() {
        if let article {
            let articles: [Article] = DataStoreManager.shared.fetchArticles()
            if articles.isEmpty == false, articles.contains(where: { $0.url == article.url }) {
                AlertViewManager.showAlert(
                    on: self,
                    title: "Error",
                    message: "Already added to bookmarks"
                )
            } else {
                DataStoreManager.shared.saveArticle(article)
                NotificationCenter.default.post(name: .didAddArticle, object: nil)
                AlertViewManager.showAlert(
                    on: self,
                    title: "Success",
                    message: "Added to bookmarks"
                )
            }
        }
    }
    
    @IBAction func shareNews() {
        guard let urlString = article?.url else { return }
        let url = URL(string: urlString)!
        let activityVC = UIActivityViewController(
            activityItems: [url],
            applicationActivities: nil
        )
        
        present(activityVC, animated: true)
    }
    
    @IBAction func openInSafari() {
        guard let urlString = article?.url else { return }
        let url = URL(string: urlString)!
        let safariVC = SFSafariViewController(url: url)
        present(safariVC, animated: true)
    }
}
