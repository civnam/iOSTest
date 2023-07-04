//
//  MainCoordinator.swift
//  TestiOSBBVA
//
//  Created by MacBook on 26/06/23.
//

import Foundation
import UIKit

final class MainCoordinator {
    
    // MARK: - Atributes
    private var mainTabBarController: MainTabBarViewController?
    private var mainLogInController: MainLoginViewController?
    private var signUpController: SignUpViewController?
    private var userLoggedController: UserLoggedViewController?
    private var logOutController: LogoutViewController?
    private var newsController: NewsViewController?
    private var articleDetailController: ArticleDetailViewController?
    private var articleWebController: ArticleWebViewController?
    private var menuController: MenuViewController?
    private var userController: UsersViewController?
    private let navigationController: UINavigationController
    private var newsNavigationController: UINavigationController?
    private var usersNavigationController: UINavigationController?
    
    // MARK: - Init of class
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Methods
    func pushMainLoginViewController() {
        
        self.mainLogInController = MainLoginViewController.getInstance(storyboardName: .login)
        self.mainLogInController?.coordinatorDelegate = self
        self.navigationController.pushViewController(self.mainLogInController ?? MainLoginViewController(), animated: true)
    }
    
    func pushSignUpViewController(user: User?) {
        
        self.signUpController = SignUpViewController.getInstance(storyboardName: .login)
        self.signUpController?.user = user
        self.signUpController?.coordinatorDelegate = self
        self.navigationController.pushViewController(self.signUpController ?? SignUpViewController(), animated: true)
    }
    
    func pushUserLoggedViewController() {
        
        self.userLoggedController = UserLoggedViewController.getInstance(storyboardName: .login)
        self.userLoggedController?.coordinatorDelegate = self
        self.navigationController.pushViewController(self.userLoggedController ?? UserLoggedViewController(), animated: true)
    }
    
    func pushMainTabBarController() {
        
        self.mainTabBarController = MainTabBarViewController(newsViewController: self.getNewsViewController(),
                                                             usersViewController: self.getUsersViewController(),
                                                             logOutViewController: self.getLogoutViewController())
        self.mainTabBarController?.coordinatorDelegate = self
        self.mainTabBarController?.modalPresentationStyle = .fullScreen
        self.navigationController.present(self.mainTabBarController ?? MainTabBarViewController(newsViewController: self.getNewsViewController(), usersViewController: self.getUsersViewController(),logOutViewController: self.getLogoutViewController()), animated: true)
    }

    func getNewsViewController() -> UIViewController {
        
        self.newsController = NewsViewController.getInstance(storyboardName: .news)
        self.newsController?.coordinatorDelegate = self
        self.newsNavigationController = UINavigationController(rootViewController: self.newsController ?? NewsViewController())
        return self.newsNavigationController ?? NewsViewController()
    }
    
    func getUsersViewController() -> UIViewController {
        
        self.userController = UsersViewController.getInstance(storyboardName: .users)
        self.userController?.coordinatorDelegate = self
        self.usersNavigationController = UINavigationController(rootViewController: self.userController ?? UsersViewController())
        return self.usersNavigationController ?? UsersViewController()
    }
    
    
    func getLogoutViewController() -> UIViewController {
        
        self.logOutController = LogoutViewController.getInstance(storyboardName: .logout)
        self.logOutController?.coordinatorDelegate = self
        return self.logOutController ?? LogoutViewController()
    }
    
    func pushArticleDetailViewController(with article: Article) {
        
        self.articleDetailController = ArticleDetailViewController.getInstance(storyboardName: .detail)
        self.articleDetailController?.presenter.article = article
        self.articleDetailController?.coordinatorDelegate = self
        self.newsNavigationController?.pushViewController(self.articleDetailController ?? ArticleDetailViewController(), animated: true)
    }
    
    func pushArticleWebViewController(with link: String) {
        
        self.articleWebController = ArticleWebViewController.getInstance(storyboardName: .detail)
        self.articleWebController?.webUrl = link
        self.newsNavigationController?.present(self.articleWebController ?? ArticleWebViewController(), animated: true)
    }
    
    func pushCategoryMenuViewController() {
        
        self.menuController = MenuViewController.getInstance(storyboardName: .news)
        self.menuController?.filterDelegate = self.newsController
        self.menuController?.coordinatorDelegate = self
        self.newsNavigationController?.present(self.menuController ?? MenuViewController(), animated: true)
    }
    
    func pushUsersViewController() {
        
        self.userController = UsersViewController.getInstance(storyboardName: .users)
        self.userController?.coordinatorDelegate = self
        self.navigationController.pushViewController(self.userController ?? UsersViewController(), animated: true)
    }
    
    func showErrorAlertController(errorDescription: String?) {
        
        let errorAlert = createErrorAlert(errorDescription: errorDescription)
        self.navigationController.present(errorAlert, animated: true)
    }
    
    private func createErrorAlert(errorDescription: String?) -> UIAlertController {
        
        let alertController = UIAlertController(title: "Error", message: errorDescription ?? "An error has ocurred", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Accept", style: .default)
        alertController.addAction(alertAction)
        return alertController
    }
    
    func dismissView() {
        self.newsNavigationController?.dismiss(animated: true)
    }
    
    func dismissToLogin() {
        self.navigationController.popToRootViewController(animated: true)
    }
}
