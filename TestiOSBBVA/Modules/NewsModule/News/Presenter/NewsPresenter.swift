//
//  NewsPresenter.swift
//  TestiOSBBVA
//
//  Created by MacBook on 23/06/23.
//

import Foundation



final class NewsPresenter {
    
    // MARK: - Delegates
    weak private var newsViewDelegate: NewsViewDelegate?
    weak private var coordinatorDelegate: MainCoordinator?
    
    // MARK: - Atributes
    private var newsApiService: NewsAPI
    private var articles = [Article]()
    
    // MARK: - Init of class
    init(newsApiService: NewsAPI) {
        self.newsApiService = newsApiService
    }
    
    // MARK: - Methods
    func setNewsDelegate(newsViewDelegate: NewsViewDelegate, coordinator: MainCoordinator?) {
        self.coordinatorDelegate = coordinator
        self.newsViewDelegate = newsViewDelegate
    }
    
    func getTotalArticles() -> Int {
        return self.articles.count
    }
    
    func getArticle(indexPath: Int) -> Article {
        return articles[indexPath]
    }
    
    func getAllArticles(country: NewsCountry = .us, category: NewsCategory = .sports) {
        
        self.newsApiService.getNewsFromAPI(country: country.endPoint, category: category.endPoint, completion: { [weak self] articles, error in
            guard let articles = articles else {
                self?.coordinatorDelegate?.showErrorAlertController(errorDescription: error?.localizedDescription)
                return
            }
            self?.articles = articles
            self?.newsViewDelegate?.showNews()
        })
    }
    
}
