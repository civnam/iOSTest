//
//  MainLoginViewController.swift
//  TestiOSBBVA
//
//  Created by MacBook on 27/06/23.
//

import UIKit
import FirebaseAuth

class MainLoginViewController: BaseViewController, ControllerInstanceDelegate {
    
    // MARK: - IBOutlets
    @IBOutlet weak var emailTxtFld: UITextField!
    @IBOutlet weak var passwordTxtFld: UITextField!
    @IBOutlet weak var logInBtn: UIButton!
    @IBOutlet weak var showPasswordBtn: UIButton!
    @IBOutlet weak var profileImgVw: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Atributes
    private var emailText: String = ""
    private var passwordText: String = ""
    private var user: User?
    
    // MARK: - Delegates
    weak var coordinatorDelegate: MainCoordinator?
    private var presenter = LoginPresenter()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.emailTxtFld.delegate = self
        self.passwordTxtFld.delegate = self
        let dismissKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(dismissKeyboardGesture)
        self.closePreviousSession()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        self.passwordTxtFld.isSecureTextEntry = true
        self.setCredentialsFirstUser()
        self.setLoginButton()
    }
    
    // MARK: - IBActions
    @IBAction func userLogIn(_ sender: UIButton) {
    
        guard let email = self.emailTxtFld.text,
              let password = self.passwordTxtFld.text,
              let coordinator = self.coordinatorDelegate else {
            return
        }
        
        self.startLoadingAnimation()
        
        self.presenter.logInUser(email: email, password: password, coordinator: coordinator, callback: {
            self.stopLoadingAnimation()
        })
    }
    
    @IBAction func userSignUp(_ sender: UIButton) {
        self.coordinatorDelegate?.pushSignUpViewController(user: self.user)
    }
    
    @IBAction func forgotPasswordAction(_ sender: UIButton) {
        
    }
    
    @IBAction func showPassword(_ sender: UIButton) {
        self.passwordTxtFld.isSecureTextEntry.toggle()
    }
    
    // MARK: - Methods
    private func closePreviousSession() {
        do {
            try Auth.auth().signOut()
        } catch {
            self.coordinatorDelegate?.showErrorAlertController(errorDescription: error.localizedDescription)
        }
    }
    
    private func setCredentialsFirstUser() {
        
        self.user = self.presenter.getCredentialsFirstUser()
        self.emailText = self.user?.email ?? ""
        self.passwordText = self.user?.login.password ?? ""
        if let userImgUrl = self.user?.picture.medium {
            self.profileImgVw.loadImage(urlStr: userImgUrl)
        }
        self.emailTxtFld.text = self.emailText
        self.passwordTxtFld.text = self.passwordText
    }
    
    private func setLoginButton() {
        
        self.emailText = self.emailTxtFld.text ?? ""
        self.passwordText = self.passwordTxtFld.text ?? ""
        self.validateIfEmptyTextFields()
    }
    
    private func startLoadingAnimation() {
        self.activityIndicator.isHidden = false
        self.activityIndicator.startAnimating()
        self.logInBtn.tintColor = .customBlue
        self.logInBtn.isEnabled = false
    }
    
    private func stopLoadingAnimation() {
        self.activityIndicator.isHidden = true
        self.activityIndicator.stopAnimating()
        self.logInBtn.tintColor = .white
        self.logInBtn.isEnabled = true
    }
    
    @objc private func dismissKeyboard() {
        self.view.endEditing(true)
    }
}

extension MainLoginViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        switch textField.tag {
            
        case 1:
            self.emailText = (emailTxtFld.text! as NSString).replacingCharacters(in: range, with: string)
            break
        case 2:
            self.passwordText = (passwordTxtFld.text! as NSString).replacingCharacters(in: range, with: string)
            break
        default:
            break
        }

        self.validateIfEmptyTextFields()
        
        return true
        
    }
    
    private func enableLoginButton() {
        
        self.logInBtn.backgroundColor = UIColor.customBlue
        self.logInBtn.isEnabled = true
    }
    
    private func disableLoginButton() {
        
        self.logInBtn.backgroundColor = .lightGray
        self.logInBtn.isEnabled = false
    }
    
    private func validateIfEmptyTextFields() {
        
        if emailText != "" && passwordText != "" {
            self.enableLoginButton()
        } else {
            self.disableLoginButton()
        }
    }
}
