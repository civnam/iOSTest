//
//  String+Extension.swift
//  TestiOSBBVA
//
//  Created by MacBook on 23/06/23.
//

import Foundation

extension String {
    
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
}
