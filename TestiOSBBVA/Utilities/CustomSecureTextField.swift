//
//  CustomSecureTextField.swift
//  TestiOSBBVA
//
//  Created by Isaac Dimas on 28/06/23.
//

import UIKit

class CustomSecureTextField: UITextField {
    
    override open func becomeFirstResponder() -> Bool {
        
        super.becomeFirstResponder()
        
        if !isSecureTextEntry { return true }
        
        if let currentText = text {
            
            self.text = ""
            insertText(currentText)
        }
        
        return true
    }
}
