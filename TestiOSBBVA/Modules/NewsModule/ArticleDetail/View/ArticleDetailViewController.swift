//
//  DetailNewsViewController.swift
//  TestiOSBBVA
//
//  Created by Isaac Dimas on 27/06/23.
//

import UIKit

class ArticleDetailViewController: BaseViewController, ControllerInstanceDelegate {

    // MARK: - IBOutlets
    @IBOutlet weak var articleHourBtn: UIButton!
    @IBOutlet weak var articleTitleTxtVw: UITextView!
    @IBOutlet weak var articleImgVw: UIImageView!
    @IBOutlet weak var articleDateLbl: UILabel!
    @IBOutlet weak var articleDescriptionTxtVw: UITextView!
    @IBOutlet weak var readMoreBtn: UIButton!
    @IBOutlet weak var articleAuthorNameLbl: UILabel!
    @IBOutlet weak var articleCategoryLbl: UILabel!
    
    // MARK: - Delegates
    weak var coordinatorDelegate: MainCoordinator?
    var presenter = ArticleDetailPresenter()
    
    // MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNews()
        self.tabBarController?.tabBar.isHidden = true
    }
    
    
    // MARK: - IBActions
    @IBAction private func readMore(_ sender: UIButton) {
        guard let readMoreUrl = self.presenter.getReadMoreUrl() else {
            self.readMoreBtn.isUserInteractionEnabled = false
            self.readMoreBtn.tintColor = .gray
            return
        }
        self.coordinatorDelegate?.pushArticleWebViewController(with: readMoreUrl)
    }
    
    // MARK: - Methods
    private func setNews() {
        self.articleHourBtn.setTitle(self.presenter.getArticleDate(), for: .normal)
        self.articleTitleTxtVw.text = self.presenter.getArticleTitle()
        self.articleImgVw.loadImage(urlStr: self.presenter.getArticleImageUrl())
        self.articleDateLbl.text = self.presenter.getArticleDate()
        self.articleDescriptionTxtVw.text = self.presenter.getArticleContent()
        self.articleAuthorNameLbl.text = self.presenter.getArticleAuthor()
    }

}
