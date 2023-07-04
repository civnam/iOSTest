//
//  UsersPresenter.swift
//  TestiOSBBVA
//
//  Created by MacBook on 27/06/23.
//

import Foundation

final class UsersPresenter {
    
    // MARK: - Atributes
    private var usersApiService: UsersAPI
    private var users = [User]()
    
    // MARK: - Delegates
    weak private var usersViewDelegate: UsersViewDelegate?
    
    // MARK: - Init of class
    init(usersApiService: UsersAPI) {
        self.usersApiService = usersApiService
    }
    
    // MARK: - Methods
    func setUsersDelegate(usersViewDelegate: UsersViewDelegate) {
        self.usersViewDelegate = usersViewDelegate
    }
    
    func getTotalUsers() -> Int {
        return self.users.count
    }
    
    func getUser(indexPath: Int) -> User {
        return users[indexPath]
    }
    
    func getUsersFromApi() {
        
        self.usersApiService.getUsersFromAPI(completion: { [weak self] users in
            self?.users.append(contentsOf: users)
            self?.usersViewDelegate?.refreshData()
        })
    }
    
    func isPaginating() -> Bool {
        return self.usersApiService.isPaginating
    }
}
