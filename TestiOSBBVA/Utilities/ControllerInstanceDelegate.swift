//
//  ViewController+Extension.swift
//  TestiOSBBVA
//
//  Created by MacBook on 26/06/23.
//

import Foundation
import UIKit

enum Storyboard: String {
    
    case news = "News"
    case detail = "ArticleDetail"
    case users = "User"
    case login = "Login"
    case logout = "Logout"
}

protocol ControllerInstanceDelegate {
    
    static func getInstance(storyboardName: Storyboard) -> Self
}

extension ControllerInstanceDelegate where Self: UIViewController {
    
    static func getInstance(storyboardName: Storyboard) -> Self {
        
        let id = String(describing: self)
        let storyboard = UIStoryboard(name: storyboardName.rawValue, bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: id) as! Self
        return viewController
    }
}
