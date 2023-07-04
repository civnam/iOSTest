//
//  NewsError.swift
//  TestiOSBBVA
//
//  Created by Isaac Dimas on 03/07/23.
//

import Foundation

enum NewsError: Error {
    
    case badRequest(String?)
    case unauthorized(String?)
    case tooManyRequests(String?)
    case serverError(String?)
    case decodeFailure(String?)
    case urlNotFound(String?)
}
