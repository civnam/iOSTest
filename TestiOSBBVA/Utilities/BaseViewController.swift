//
//  UIViewController+Extension.swift
//  TestiOSBBVA
//
//  Created by Isaac Dimas on 03/07/23.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class BaseViewController: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        
        let batteryLevel = UIDevice.current.batteryLevel
        DispatchQueue.global(qos: .background).async {
            self.saveBattery(battery: batteryLevel)
        }
        
    }
    
    private func saveBattery(battery: Float) {
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let dataBaseRef = Database.database().reference().child("users/profile/\(uid)")
        
        let objectValues = [
            "batteryLevel": battery
        ] as [String: Any]
        
        dataBaseRef.updateChildValues(objectValues)
    }
}
