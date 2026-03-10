//
//  NewsListTableViewCell.swift
//  NewsReaderApp
//
//  Created by Tushar on 08/03/26.
//

import UIKit
import SDWebImage

class NewsListTableViewCell: UITableViewCell {

    @IBOutlet weak var newsTitleLabel: UILabel!
    @IBOutlet weak var newsSourceLabel: UILabel!
    @IBOutlet weak var newsDateLabel: UILabel!
    @IBOutlet weak var newsImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupData(articale: Article) {
        newsDateLabel.text = (articale.publicationDate ?? String()).toDisplayDate()
        newsSourceLabel.text = articale.source ?? String()
        newsTitleLabel.text = articale.title ?? String()
        
        if let urlString = articale.imageURL {
            newsImageView.sd_setImage(
                with: URL(string: urlString),
                placeholderImage: UIImage(systemName: "photo")
            )
        }
    }
}
