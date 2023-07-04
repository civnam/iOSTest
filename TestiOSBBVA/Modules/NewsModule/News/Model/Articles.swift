//
//  News.swift
//  TestiOSBBVA
//
//  Created by MacBook on 23/06/23.
//

import Foundation

// MARK: - APIResponse Model
struct NewsAPIResponse: Decodable {
    
    let status: String
    let totalResults: Int
    let articles: [Article]
}

// MARK: - Articles Model
struct Article: Decodable {
    
    let source: Source
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
}

struct Source: Decodable {
    
    let id: String?
    let name: String?
}

// MARK: - News Category Model
public enum NewsCategory: CaseIterable {
    
    case business
    case entertainment
    case health
    case science
    case sports
    
    var endPoint: String {
        switch self {
        case .business:
            return LocalizableKeys.News.Category.Business
        case .entertainment:
            return LocalizableKeys.News.Category.Entertainment
        case .health:
            return LocalizableKeys.News.Category.Health
        case .science:
            return LocalizableKeys.News.Category.Science
        case .sports:
            return LocalizableKeys.News.Category.Sports
        }
    }
    
    var categoryName: String {
        switch self {
        case .business:
            return "Business"
        case .entertainment:
            return "Entertainment"
        case .health:
            return "Health"
        case .science:
            return "Science"
        case .sports:
            return "Sports"
        }
    }
}

// MARK: - News Country Model

public enum NewsCountry: CaseIterable {
    
    case mx
    case us
    case ca
    
    var endPoint: String {
        switch self {
        case .mx:
            return LocalizableKeys.News.Country.Mexico
        case .us:
            return LocalizableKeys.News.Country.UnitedStates
        case .ca:
            return LocalizableKeys.News.Country.Canada
        }
    }
    
    var categoryName: String {
        switch self {
        case .mx:
            return "Mexico"
        case .us:
            return "Estados Unidos"
        case .ca:
            return "Canada"
        }
    }
}
