//
//  NewsTableViewCell.swift
//  TestiOSBBVA
//
//  Created by MacBook on 26/06/23.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    
    // MARK: - Iboutlets
    @IBOutlet weak var newsImgVw: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
    // MARK: - Methods
    func setArticle(article: Article) {
        
        self.titleLbl.text = article.title
        self.authorLabel.text = article.author
        self.newsImgVw.loadImage(urlStr: article.urlToImage ?? "")
        self.newsImgVw.layer.cornerRadius = 10
    }
}
