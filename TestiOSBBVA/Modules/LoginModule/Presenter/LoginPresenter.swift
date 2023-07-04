//
//  LoginPresenter.swift
//  TestiOSBBVA
//
//  Created by Isaac Dimas on 27/06/23.
//

import Foundation
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase

final class LoginPresenter {
    
    // MARK: - Atributes
    private var usersApiService: UsersAPI = UsersAPI()
    
    // MARK: - Methods
    func logInUser(email: String, password: String, coordinator: MainCoordinator, callback: @escaping () -> Void) {

        Auth.auth().signIn(withEmail: email, password: password, completion: { result, error in
            
            if error == nil {
                coordinator.pushMainTabBarController()
            } else {
                coordinator.showErrorAlertController(errorDescription: error?.localizedDescription)
            }
            
            callback()
        })
    }
    
    func signUpUser(email: String, password: String, profilePicture: UIImage?, coordinator: MainCoordinator, callback: @escaping () -> Void) {
        
        Auth.auth().createUser(withEmail: email, password: password, completion: { result, error in
            
            guard error == nil else {
                
                coordinator.showErrorAlertController(errorDescription: error?.localizedDescription)
                callback()
                return
            }
            
            if let profilePicture = profilePicture {
                
                self.uploadProfilePicture(image: profilePicture, completion: { url in
                    
                    guard let url = url else {
                        coordinator.showErrorAlertController(errorDescription: "Something went wrong with the image upload")
                        return
                    }
                    
                    let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                    changeRequest?.photoURL = url
                    
                    changeRequest?.commitChanges(completion: { error in
                        
                        guard error == nil else {
                            
                            coordinator.showErrorAlertController(errorDescription: error?.localizedDescription)
                            callback()
                            return
                        }
                        
                        self.saveProfile(email: email, profileImgUrl: url, completion: { success in
                            
                            guard success else {
                                
                                coordinator.showErrorAlertController(errorDescription: error?.localizedDescription)
                                callback()
                                return
                            }
                            
                            coordinator.pushMainTabBarController()
                            coordinator.dismissToLogin()
                            callback()
                        })
                        
                    })
                    
                })
            }

        })
    }
    
    private func uploadProfilePicture(image: UIImage, completion: @escaping (URL?) -> Void) {
        
        guard let uid = Auth.auth().currentUser?.uid,
        let imageData = image.jpegData(compressionQuality: 0.75) else {
            
            completion(nil)
            return
        }
        let storageRef = Storage.storage().reference().child("userImage/\(uid)")
        
        let storageMetaData = StorageMetadata()
        storageMetaData.contentType = "image/jpg"
        
        storageRef.putData(imageData, metadata: storageMetaData, completion: { (metaData, error) in
            
            guard error == nil else {
                
                completion(nil)
                return
            }
            
            storageRef.downloadURL(completion: { url, error in
                completion(url)
            })
            
        })
        
    }
    
    private func saveProfile(email: String, profileImgUrl: URL, completion: @escaping (Bool) -> Void) {
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let dataBaseRef = Database.database().reference().child("users/profile/\(uid)")
        
        let userObject = [
            "email": email,
            "photoUrl": profileImgUrl.absoluteString,
            "batteryLevel": UIDevice.current.batteryLevel
        ] as [String: Any]
        
        dataBaseRef.setValue(userObject, withCompletionBlock: { error, dataBaseRef in
            completion(error == nil)
        })
    }
                
    func getCredentialsFirstUser() -> User? {
        
        let user = self.usersApiService.getFirstUserCredentialsOfApiResponse()
        return user
    }
}
