//
//  DetailNewsPresenter.swift
//  TestiOSBBVA
//
//  Created by Isaac Dimas on 27/06/23.
//

import Foundation

final class ArticleDetailPresenter {
    
    // MARK: - Atributes
    var article: Article?
    
    // MARK: - Methods
    func getArticleTitle() -> String {
        return self.article?.title ?? "No title available"
    }
    
    func getArticleImageUrl() -> String {
        return self.article?.urlToImage ?? ""
    }
    
    func getArticleDate() -> String {
        return self.article?.publishedAt ?? "Unknown"
    }
    
    func getArticleAuthor() -> String {
        return self.article?.author ?? "Unknown"
    }
    
    func getArticleContent() -> String {
        return self.article?.description ?? "No available content"
    }
    
    func getReadMoreUrl() -> String? {
        return self.article?.url
    }
    
}
