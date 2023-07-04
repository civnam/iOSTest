//
//  NewsViewController.swift
//  TestiOSBBVA
//
//  Created by MacBook on 23/06/23.
//

import UIKit

protocol NewsViewDelegate: NSObject {
    func showNews()
}

protocol NewsFilterDelegate: NSObject {
    func getNewsByCategory(country: NewsCountry, category: NewsCategory)
}

class NewsViewController: BaseViewController, ControllerInstanceDelegate {
    
    // MARK: - IBOutlets
    @IBOutlet weak var newsTblVw: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    weak private var cell: NewsTableViewCell?
    
    // MARK: - Delegates
    weak var coordinatorDelegate: MainCoordinator?
    private var presenter = NewsPresenter(newsApiService: NewsAPI())
    
    // MARK: - Lifecycle
    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.setNewsDelegate(newsViewDelegate: self, coordinator: self.coordinatorDelegate)
        self.presenter.getAllArticles()
        self.setTableViewDelegates()
        self.registerCells()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        self.title = LocalizableKeys.News.newsTitle
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        self.activityIndicator.startAnimating()
    }
    
    // MARK: - IBActions
    @IBAction func showCategoryMenu(_ sender: UIBarButtonItem) {
        self.coordinatorDelegate?.pushCategoryMenuViewController()
    }
    
    // MARK: - Methods
    private func registerCells() {
        self.newsTblVw.register(UINib(nibName: LocalizableKeys.News.newsCellNibName,
                                      bundle: nil),
                                forCellReuseIdentifier: LocalizableKeys.News.newsCellId)
    }
    
    private func setTableViewDelegates() {
        
        self.newsTblVw.delegate = self
        self.newsTblVw.dataSource = self
    }
}

extension NewsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter.getTotalArticles()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        self.cell = self.newsTblVw.dequeueReusableCell(withIdentifier: LocalizableKeys.News.newsCellId, for: indexPath) as? NewsTableViewCell
        let article = self.presenter.getArticle(indexPath: indexPath.row)
        self.cell?.setArticle(article: article)
        return self.cell ?? NewsTableViewCell()
    }
    
}

extension NewsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.newsTblVw.deselectRow(at: indexPath, animated: true)
        let article = presenter.getArticle(indexPath: indexPath.row)
        self.coordinatorDelegate?.pushArticleDetailViewController(with: article)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 106
    }
}

extension NewsViewController: NewsViewDelegate {
    
    func showNews() {
        
        DispatchQueue.main.async {
            
            self.newsTblVw.reloadData()
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true
        }
    }
}

extension NewsViewController: NewsFilterDelegate {
    
    func getNewsByCategory(country: NewsCountry, category: NewsCategory) {
        
        self.activityIndicator.isHidden = false
        self.activityIndicator.startAnimating()
        self.presenter.getAllArticles(country: country, category: category)
        self.title = "\(category.categoryName) News"
        LocalizableKeys.News.newsTitle = "\(category.categoryName) News"
    }
}

