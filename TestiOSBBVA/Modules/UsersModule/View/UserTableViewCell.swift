//
//  UsersTableViewCell.swift
//  TestiOSBBVA
//
//  Created by MacBook on 27/06/23.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet weak var infoDescriptionLbl: UILabel!
    @IBOutlet weak var userInfoLbl: UILabel!
    @IBOutlet weak var userImgVw: UIImageView!
    @IBOutlet weak var userNameBtn: UIButton!
    @IBOutlet weak var userEmailBtn: UIButton!
    @IBOutlet weak var userLocationBtn: UIButton!
    @IBOutlet weak var userPhoneBtn: UIButton!
    @IBOutlet weak var userNationBtn: UIButton!
    
    // MARK: - Atributes
    private var user: User?
    
    // MARK: - IBActions
    @IBAction func showUserName(_ sender: UIButton) {
        
        let userName = (user?.name.title ?? "Mr") + " " + (user?.name.first ?? "Paco") + " " + (user?.name.last ?? "Garcia")
        self.setupButtonsAnimation(sender)
        self.userInfoLbl.text = userName
    }
    
    @IBAction func showUserEmail(_ sender: UIButton) {
        
        let userEmail = user?.email
        self.setupButtonsAnimation(sender)
        self.userInfoLbl.text = userEmail
    }
    
    @IBAction func showUserLocation(_ sender: UIButton) {
        
        let userLocation = (user?.location.country ?? "Mexico") + ", " + (user?.location.state ?? "CDMX")
        self.setupButtonsAnimation(sender)
        self.userInfoLbl.text = userLocation
    }
    
    @IBAction func showUserPhone(_ sender: UIButton) {
        
        let userPhone = user?.phone
        self.setupButtonsAnimation(sender)
        self.userInfoLbl.text = userPhone
    }
    
    @IBAction func showUserNation(_ sender: UIButton) {
        
        let userNation = user?.nat
        self.setupButtonsAnimation(sender)
        self.userInfoLbl.text = userNation
    }
    
    // MARK: - Methods
    func setUser(user: User) {
        
        self.user = user
        self.userImgVw.loadImage(urlStr: user.picture.medium)
        self.userImgVw.makeRounded()
        let userName = (self.user?.name.title ?? "Mr") + " " + (self.user?.name.first ?? "Paco") + " " + (self.user?.name.last ?? "Garcia")
        self.userInfoLbl.text = userName
        self.userNameBtn.tintColor = .green
    }
    
    private func setupButtonsAnimation(_ sender: UIButton?) {
        
        self.setDefaultButtonsColors()
        
        if let sender = sender {
            
            switch sender.tag {
                
            case 1:
                self.infoDescriptionLbl.text = "Hi, my name is"
                self.setActualDisplayInfoButtonColor(sender: sender)
                break
            case 2:
                self.infoDescriptionLbl.text = "My email is"
                self.setActualDisplayInfoButtonColor(sender: sender)
                break
            case 3:
                self.infoDescriptionLbl.text = "My address is"
                self.setActualDisplayInfoButtonColor(sender: sender)
                break
            case 4:
                self.infoDescriptionLbl.text = "My phone number is"
                self.setActualDisplayInfoButtonColor(sender: sender)
                break
            case 5:
                self.infoDescriptionLbl.text = "My nationality is"
                self.setActualDisplayInfoButtonColor(sender: sender)
                break
            default:
                break
            }
        }
    }
    
    private func setDefaultButtonsColors() {
        
        UIView.animate(withDuration: 1, animations: {
            
            self.userNameBtn.tintColor = .systemBlue
            self.userEmailBtn.tintColor = .systemBlue
            self.userLocationBtn.tintColor = .systemBlue
            self.userPhoneBtn.tintColor = .systemBlue
            self.userNationBtn.tintColor = .systemBlue
        })
    }
    
    private func setActualDisplayInfoButtonColor(sender: UIButton) {
        
        self.infoDescriptionLbl.alpha = 0
        self.userInfoLbl.alpha = 0
        
        UIView.animate(withDuration: 0.7, animations: {
            
            sender.tintColor = .green
            self.infoDescriptionLbl.alpha = 1
            self.userInfoLbl.alpha = 1
        })
    }
}
