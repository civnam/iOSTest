//
//  UsersViewController.swift
//  TestiOSBBVA
//
//  Created by MacBook on 27/06/23.
//

import UIKit

protocol UsersViewDelegate: NSObject {
    func refreshData()
}

class UsersViewController: BaseViewController, ControllerInstanceDelegate {

    // MARK: - IBOutlets
    @IBOutlet weak var usersTblVw: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    weak private var cell: UserTableViewCell?
    
    // MARK: - Delegates
    weak var coordinatorDelegate: MainCoordinator?
    private var presenter = UsersPresenter(usersApiService: UsersAPI())
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.setUsersDelegate(usersViewDelegate: self)
        self.presenter.getUsersFromApi()
        self.setTableView()
        self.registerCells()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        self.title = LocalizableKeys.User.usersTitle
        self.activityIndicator.startAnimating()
    }
    
    // MARK: - Methods
    private func setTableView() {
        
        self.usersTblVw.delegate = self
        self.usersTblVw.dataSource = self
        self.usersTblVw.separatorStyle = .none
    }
    
    private func registerCells() {
        self.usersTblVw.register(UINib(nibName: LocalizableKeys.User.usersCellNibName,
                                      bundle: nil),
                                 forCellReuseIdentifier: LocalizableKeys.User.usersCellId)
    }

}

extension UsersViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.presenter.getTotalUsers()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        self.cell = self.usersTblVw.dequeueReusableCell(withIdentifier: LocalizableKeys.User.usersCellId, for: indexPath) as? UserTableViewCell
        let user = self.presenter.getUser(indexPath: indexPath.row)
        self.cell?.setUser(user: user)
        return self.cell ?? NewsTableViewCell()
    }
    
}

extension UsersViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 190
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
}

extension UsersViewController: UsersViewDelegate {
    
    func refreshData() {
        
        DispatchQueue.main.async {
            
            self.usersTblVw.reloadData()
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true
        }
    }
}

extension UsersViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        
        if position > self.usersTblVw.contentSize.height - 100 - scrollView.frame.size.height {
            
            guard !self.presenter.isPaginating() else { return }
            
            self.presenter.getUsersFromApi()
        }
    }
}
