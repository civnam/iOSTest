//
//  Constants.swift
//  TestiOSBBVA
//
//  Created by MacBook on 23/06/23.
//

import Foundation

struct LocalizableKeys {
    
    struct API {
        
        static let newsApiUrl: String = "news.api.url".localized
        static let newsApiKey: String = "news.api.key".localized
        static let usersApiUrl: String = "users.api.url".localized
    }
    
    struct News {
        
        static var newsTitle = "news.title".localized
        static let newsCellNibName = "news.cell.nib.name".localized
        static let newsCellId = "news.cell.id".localized
        static let newsMenuNibName = "news.menu.nib.name".localized
        static let newsMenuCellId = "news.menu.cell.id".localized
        
        struct Country {
            
            static let Mexico = "Mexico".localized
            static let UnitedStates = "UnitedStates".localized
            static let Canada = "Canada".localized
        }
        
        struct Category {
            
            static let Business = "business".localized
            static let Entertainment = "entertainment".localized
            static let Health = "health".localized
            static let Science = "science".localized
            static let Sports = "sports".localized
        }
    }
    
    struct User {
        
        static let usersTitle = "users.title".localized
        static let usersCellNibName = "users.cell.nib.name".localized
        static let usersCellId = "users.cell.cell.id".localized
        
        struct UserEndPoint {
            
            static let numberOfResults = "users.results".localized
            static let nationality = "users.nationality".localized
            static let seed = "users.seed".localized
        }
    }
    
    struct Logout {
        static var logoutTitle = "logout.title".localized
    }
}
