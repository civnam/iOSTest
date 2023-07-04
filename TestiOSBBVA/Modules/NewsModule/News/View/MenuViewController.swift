//
//  MenuViewController.swift
//  TestiOSBBVA
//
//  Created by MacBook on 26/06/23.
//

import UIKit

final class MenuViewController: BaseViewController, ControllerInstanceDelegate {
    
    // MARK: - IBOutlets
    @IBOutlet weak var menuTblVw: UITableView!
    weak private var cell: MenuTableViewCell?
    
    // MARK: - Atributes
    weak var filterDelegate: NewsFilterDelegate?
    weak var coordinatorDelegate: MainCoordinator?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerCell()
        self.setMenuDelegates()
    }
    
    // MARK: - Methods
    private func registerCell() {
        self.menuTblVw.register(UINib(nibName: LocalizableKeys.News.newsMenuNibName, bundle: nil),
                                forCellReuseIdentifier: LocalizableKeys.News.newsMenuCellId)
    }
    
    private func setMenuDelegates() {
        self.menuTblVw.delegate = self
        self.menuTblVw.dataSource = self
    }

    @IBAction func dismissMenu(_ sender: UIButton) {
        self.coordinatorDelegate?.dismissView()
    }
    
    @objc private func getNewsByCategory(sender: UIButton) {
        self.filterDelegate?.getNewsByCategory(country: .us, category: NewsCategory.allCases[sender.tag])
        self.coordinatorDelegate?.dismissView()
    }
}

// MARK: - TableViewDataSource
extension MenuViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return NewsCategory.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        self.cell = menuTblVw.dequeueReusableCell(withIdentifier: LocalizableKeys.News.newsMenuCellId, for: indexPath) as? MenuTableViewCell
        self.cell?.categorySelection.setTitle(NewsCategory.allCases[indexPath.row].categoryName, for: .normal)
        self.cell?.categorySelection.tag = indexPath.row
        self.cell?.categorySelection.addTarget(self, action: #selector(getNewsByCategory(sender:)), for: .touchUpInside)
        
        return self.cell ?? MenuTableViewCell()
    }
    
}

extension MenuViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
}
