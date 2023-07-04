//
//  User.swift
//  TestiOSBBVA
//
//  Created by MacBook on 27/06/23.
//

import Foundation

struct UsersAPIResponse: Decodable {
    
    let results: [User]
}

struct User: Decodable {
    
    let name: UserName
    let location: UserLocation
    let email: String
    let phone: String
    let picture: UserPicture
    let nat: String
    let login: UserLogin
}

struct UserName: Decodable {
    
    let title: String
    let first: String
    let last: String
}

struct UserLocation: Decodable {
    
    let state: String
    let country: String
}

struct UserPicture: Decodable {
    
    let large: String
    let medium: String
}

struct UserLogin: Decodable {
    
    let password: String
}
