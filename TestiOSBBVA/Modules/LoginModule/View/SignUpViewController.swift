//
//  SignUpViewController.swift
//  TestiOSBBVA
//
//  Created by MacBook on 27/06/23.
//

import UIKit
import FirebaseAuth

class SignUpViewController: BaseViewController, ControllerInstanceDelegate {

    // MARK: - IBOutlets
    @IBOutlet weak var userEmailTxtFld: UITextField!
    @IBOutlet weak var userPasswordTxtFld: UITextField!
    @IBOutlet weak var signUpBtn: UIButton!
    @IBOutlet weak var profileImgVw: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private weak var imagePicker: UIImagePickerController! {
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        return imagePicker
    }
    
    // MARK: - Atributes
    var user: User?
    private var emailText: String = ""
    private var passwordText: String = ""
    
    // MARK: - Delegates
    weak var coordinatorDelegate: MainCoordinator?
    private var presenter = LoginPresenter()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        let dismissKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(dismissKeyboardGesture)
        self.setupImagePicker()
        self.userEmailTxtFld.delegate = self
        self.userPasswordTxtFld.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        self.userPasswordTxtFld.isSecureTextEntry = true
        self.profileImgVw.makeRounded()
        self.setCredentialsFirstUser()
        self.setSignupButton()
    }
    
    // MARK: - IBActions
    @IBAction func userSignUp(_ sender: UIButton) {
        
        guard let coordinator = self.coordinatorDelegate else { return }
        self.startLoadingAnimation()
        self.presenter.signUpUser(email: self.emailText, password: self.passwordText, profilePicture: self.profileImgVw.image, coordinator: coordinator, callback: {
            self.stopLoadingAnimation()
        })
    }
    
    @IBAction func showPassword(_ sender: UIButton) {
        self.userPasswordTxtFld.isSecureTextEntry.toggle()
    }
    
    // MARK: - Methods
    private func setSignupButton() {
        
        self.emailText = self.userEmailTxtFld.text ?? ""
        self.passwordText = self.userPasswordTxtFld.text ?? ""
        self.validateIfEmptyTextFields()
    }
    
    private func setCredentialsFirstUser() {
        
        self.emailText = user?.email ?? ""
        self.passwordText = user?.login.password ?? ""
        if let userImgUrl = user?.picture.medium {
            self.profileImgVw.loadImage(urlStr: userImgUrl)
        }
        self.userEmailTxtFld.text = self.emailText
        self.userPasswordTxtFld.text = self.passwordText
    }
    
    
    private func enableSignupButton() {
        
        self.signUpBtn.backgroundColor = UIColor.customBlue
        self.signUpBtn.isEnabled = true
    }
    
    private func disableSignupButton() {
        
        self.signUpBtn.backgroundColor = .lightGray
        self.signUpBtn.isEnabled = false
    }
    
    private func validateIfEmptyTextFields() {
        
        if emailText != "" && passwordText != "" && passwordText.count > 6 {
            self.enableSignupButton()
        } else {
            self.disableSignupButton()
        }
    }
    
    private func startLoadingAnimation() {
        self.activityIndicator.isHidden = false
        self.activityIndicator.startAnimating()
        self.signUpBtn.tintColor = .customBlue
        self.signUpBtn.isEnabled = false
    }
    
    private func stopLoadingAnimation() {
        self.activityIndicator.isHidden = true
        self.activityIndicator.stopAnimating()
        self.signUpBtn.tintColor = .white
        self.signUpBtn.isEnabled = true
    }
    
    private func setupImagePicker() {
        let imageTap = UITapGestureRecognizer(target: self, action: #selector(openImagePicker))
        self.profileImgVw.isUserInteractionEnabled = true
        self.profileImgVw.addGestureRecognizer(imageTap)
    }
    
    @objc private func openImagePicker() {
        self.present(self.imagePicker, animated: true)
    }
    
    @objc private func dismissKeyboard() {
        self.view.endEditing(true)
    }
}

extension SignUpViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        switch textField.tag {
            
        case 1:
            self.emailText = (userEmailTxtFld.text! as NSString).replacingCharacters(in: range, with: string)
            break
        case 2:
            self.passwordText = (userPasswordTxtFld.text! as NSString).replacingCharacters(in: range, with: string)
            break
        default:
            break
        }
        
        self.validateIfEmptyTextFields()
        
        return true
        
    }
}

extension SignUpViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            self.profileImgVw.image = pickedImage
        }
        picker.dismiss(animated: true)
    }
}
