//
//  UsersAPI.swift
//  TestiOSBBVA
//
//  Created by MacBook on 27/06/23.
//

import Foundation

class UsersAPI {
    
    // MARK: - Atributes
    private let apiUrl: String = LocalizableKeys.API.usersApiUrl
    private let numberOfResults: String = LocalizableKeys.User.UserEndPoint.numberOfResults
    private let seed: String = LocalizableKeys.User.UserEndPoint.seed
    private let nationality: String = LocalizableKeys.User.UserEndPoint.nationality
    private var pageNumber: Int = 1
    private var firstUser: User?
    var isPaginating: Bool = false
    
    // MARK: - Methods
    func getUsersFromAPI(pagination: Bool = true ,completion: @escaping ( [User] ) -> Void) {
        
        if pagination { self.isPaginating.toggle() }
        
        let urlStr = apiUrl + "page=\(pageNumber)" + numberOfResults + seed + nationality
        
        guard let url = URL(string: urlStr) else {
            print("URL no encontrada")
            return
        }
        
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
            
            if error != nil {
                print("A problem has ocurred", error?.localizedDescription ?? "")
            }
            
            do {
                if let data = data {
                    let decoder = JSONDecoder()
                    let parsedData = try decoder.decode(UsersAPIResponse.self, from: data)
                    self.pageNumber += 1
                    completion(parsedData.results)
                    
                    if pagination { self.isPaginating.toggle() }
                }
            } catch {
                print("A problem has ocurred", error.localizedDescription)
            }
        })
        
        task.resume()
    }
    
    func getFirstUserCredentialsOfApiResponse() -> User? {
        
        let group = DispatchGroup()
        group.enter()
        
        self.getUsersFromAPI(completion: { users in
            let user = users.first
            self.firstUser = user
            group.leave()
        })
        
        group.wait()
        
        return self.firstUser ?? nil
    }
}
