//
//  ArticleWebViewController.swift
//  TestiOSBBVA
//
//  Created by Isaac Dimas on 27/06/23.
//

import UIKit
import WebKit

final class ArticleWebViewController: BaseViewController, ControllerInstanceDelegate {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var webView: WKWebView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Atributes
    var webUrl: String?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupWebView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: - Methods
    
    private func setupWebView() {
        guard let webUrl = webUrl else {
            return
        }
        let urlLink = webUrl.filter{ $0 != " "}
        if let url = URL(string: urlLink) {
            let urlRequest = URLRequest(url: url)
            self.webView.load(urlRequest)
            self.webView.navigationDelegate = self
        }
    }
}

extension ArticleWebViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        self.activityIndicator.startAnimating()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.activityIndicator.stopAnimating()
        self.activityIndicator.isHidden = true
    }
}
