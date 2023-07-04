//
//  MainTabBarViewController.swift
//  TestiOSBBVA
//
//  Created by Isaac Dimas on 27/06/23.
//

import UIKit

class MainTabBarViewController: UITabBarController, ControllerInstanceDelegate {
    
    // MARK: - Atributes
    weak var coordinatorDelegate: MainCoordinator?
    private var newsViewController: UIViewController
    private var usersViewController: UIViewController
    private var logOutViewController: UIViewController
    
    private var shapeLayer: CALayer?
    private var upperLineView: UIView?
    private let spacing: CGFloat = 12
    
    // MARK: - Init of class
    init(newsViewController: UIViewController, usersViewController: UIViewController, logOutViewController: UIViewController) {
        self.newsViewController = newsViewController
        self.usersViewController = usersViewController
        self.logOutViewController = logOutViewController
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        self.setupViewControllers()
        self.setCustomTabBar()
    }
    
    // MARK: - Methods
    private func setupViewControllers() {
        
        let newsController = self.newsViewController
        let usersController = self.usersViewController
        let logOutController = self.logOutViewController

        if #available(iOS 13.0, *) {
            
            newsController.tabBarItem.image = UIImage(systemName: "house")
            usersController.tabBarItem.image = UIImage(systemName: "star")
            logOutController.tabBarItem.image = UIImage(systemName: "person")
        } else {
            
            newsController.tabBarItem.image = UIImage(named: "NewsLogo")
            usersController.tabBarItem.image = UIImage(named: "UsersLogo")
            logOutController.tabBarItem.image = UIImage(named: "LogoutLogo")
        }

        newsController.tabBarItem.title = LocalizableKeys.News.newsTitle
        usersController.tabBarItem.title = LocalizableKeys.User.usersTitle
        logOutController.tabBarItem.title = LocalizableKeys.Logout.logoutTitle

        self.viewControllers = [newsController, usersController, logOutController]
    }
    
    private func setCustomTabBar() {
        
        let xPosition: CGFloat = 10
        let yPosition: CGFloat = 14
        let width = tabBar.bounds.width - xPosition * 2
        let height = tabBar.bounds.height + yPosition * 2
        
        let roundLayer = CAShapeLayer()
        
        let bezierPath = UIBezierPath(roundedRect: CGRect(x: xPosition,
                                                          y: tabBar.bounds.minY - yPosition,
                                                          width: width,
                                                          height: height),
                                      cornerRadius: height / 2)
        
        roundLayer.path = bezierPath.cgPath
        
        tabBar.layer.insertSublayer(roundLayer, at: 0)
        tabBar.itemWidth = width / 5
        tabBar.itemPositioning = .centered
        
        roundLayer.fillColor = UIColor.customBlue.cgColor
        
        tabBar.tintColor = .green
        tabBar.unselectedItemTintColor = .white
    }

}

extension MainTabBarViewController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        guard let fromView = selectedViewController?.view, let toView = viewController.view else {
            return false
        }
        
        if fromView != toView {
            UIView.transition(from: fromView, to: toView, duration: 0.3, options: [.transitionCrossDissolve], completion: nil)
        }
        
        return true
    }
}
