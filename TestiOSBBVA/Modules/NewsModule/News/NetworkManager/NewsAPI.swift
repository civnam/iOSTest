//
//  NewsNetworkDataManager.swift
//  TestiOSBBVA
//
//  Created by MacBook on 23/06/23.
//

import Foundation

class NewsAPI {
    
    // MARK: - Atributes
    private let apiUrl: String = LocalizableKeys.API.newsApiUrl
    private let apiKey: String = LocalizableKeys.API.newsApiKey
    private let pageSize: String = "&pageSize=10"
    
    // MARK: - Methods
    func getNewsFromAPI(country: String, category: String, completion: @escaping ( [Article]?, NewsError? ) -> Void) {
        
        let urlStr = apiUrl + country + category + pageSize + apiKey
        
        guard let url = URL(string: urlStr) else {
            completion(nil, .urlNotFound("URL Not Found"))
            return
        }
        
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
            
            guard let response = response as? HTTPURLResponse else { return }
            
            switch response.statusCode {
                
            case 400:
                completion(nil, .badRequest(error?.localizedDescription))
                break
            case 401:
                completion(nil, .unauthorized(error?.localizedDescription))
                break
            case 429:
                completion(nil, .tooManyRequests(error?.localizedDescription))
                break
            case 500:
                completion(nil, .serverError(error?.localizedDescription))
                break
            default:
                
                do {
                    if let data = data {
                        let decoder = JSONDecoder()
                        let parsedData = try decoder.decode(NewsAPIResponse.self, from: data)
                        completion(parsedData.articles, nil)
                    }
                } catch {
                    completion(nil, .decodeFailure(error.localizedDescription))
                }
                
                break
            }
        })
        
        task.resume()
    }
    
}
