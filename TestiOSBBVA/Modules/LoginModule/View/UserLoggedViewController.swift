//
//  UserLoggedViewController.swift
//  TestiOSBBVA
//
//  Created by MacBook on 27/06/23.
//

import UIKit
import FirebaseAuth

class UserLoggedViewController: BaseViewController, ControllerInstanceDelegate {

    // MARK: - IBOutlets
    @IBOutlet weak var userEmailLbl: UILabel!
    @IBOutlet weak var userPasswordTxtFld: UITextField!
    @IBOutlet weak var logInBtn: UIButton!
    @IBOutlet weak var passwordTxtFld: UITextField!
    
    // MARK: - Atributes
    private var passwordText: String = ""
    
    // MARK: - Delegates
    weak var coordinatorDelegate: MainCoordinator?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.userPasswordTxtFld.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        self.userPasswordTxtFld.isSecureTextEntry = true
        self.disableLoginButton()
        
        do {
            try Auth.auth().signOut()
            self.coordinatorDelegate?.dismissToLogin()
        } catch {
            self.coordinatorDelegate?.showErrorAlertController(errorDescription: error.localizedDescription)
        }
    }

    // MARK: - IBActions
    @IBAction func userLogIn(_ sender: UIButton) {
        self.coordinatorDelegate?.pushMainTabBarController()
    }
    
    @IBAction func showPassword(_ sender: UIButton) {
        self.userPasswordTxtFld.isSecureTextEntry.toggle()
    }
    
    // MARK: - Methods
    private func enableLoginButton() {
        
        self.logInBtn.backgroundColor = UIColor.customBlue
        self.logInBtn.isEnabled = true
    }
    
    private func disableLoginButton() {
        
        self.logInBtn.backgroundColor = .lightGray
        self.logInBtn.isEnabled = false
    }
}

extension UserLoggedViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        self.passwordText = (passwordTxtFld.text! as NSString).replacingCharacters(in: range, with: string)
        
        let isPasswordempty = passwordText != ""
        
        if isPasswordempty {
            self.enableLoginButton()
        } else {
            self.disableLoginButton()
        }
        
        return true
        
    }
}
