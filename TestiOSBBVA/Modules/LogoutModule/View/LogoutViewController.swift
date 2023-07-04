//
//  LogoutViewController.swift
//  TestiOSBBVA
//
//  Created by Isaac Dimas on 28/06/23.
//

import UIKit
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase

class LogoutViewController: BaseViewController, ControllerInstanceDelegate {

    // MARK: - IBOutlets
    @IBOutlet weak var userImgVw: UIImageView!
    @IBOutlet weak var userBatteryLbl: UILabel!
    @IBOutlet weak var userEmailLbl: UILabel!
    
    // MARK: - Delegates
    weak var coordinatorDelegate: MainCoordinator?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.userImgVw.makeRounded()
        self.setCurrentUserData()
    }
    
    // MARK: - IBActions
    @IBAction func userLogOut(_ sender: UIButton) {
        
        do {
            try Auth.auth().signOut()
            self.coordinatorDelegate?.dismissView()
        } catch {
            self.coordinatorDelegate?.showErrorAlertController(errorDescription: error.localizedDescription)
        }
    }
    
    func setCurrentUserData() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let database = Database.database().reference().child("users/profile/\(uid)")
        database.getData(completion: { error, dataSnapshot in
            
            guard let value = dataSnapshot?.value as? [String: Any] else {
                return
            }
            
            let photoUrl = value["photoUrl"] as? String
            let email = value["email"] as? String
            let batteryLevel = value["batteryLevel"] as? Float
            
            self.userEmailLbl.text = email
            self.userImgVw.loadImage(urlStr: photoUrl ?? "")
            self.userBatteryLbl.text = String(batteryLevel ?? 0.0)
        })
    }
    
}
