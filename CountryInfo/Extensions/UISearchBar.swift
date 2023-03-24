//
//  UISearchBar.swift
//  CountryInfo
//
//  Created by João Rouxinol on 24/03/2023.
//

import Foundation
import UIKit

extension UISearchBar {
    func setIconColor(_ color: UIColor) {
        guard let textfield = self.value(forKey: "searchField") as? UITextField, let leftView = textfield.leftView as? UIImageView else { return }
            leftView.image = leftView.image?.withRenderingMode(.alwaysTemplate)
            leftView.tintColor = UIColor.white
    }
    
    func setPlaceholderColor(_ color: UIColor) {
        guard let textfield = self.value(forKey: "searchField") as? UITextField else { return }
            textfield.attributedPlaceholder = NSAttributedString(string: textfield.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
    }
    
    func setTextColor(_ color: UIColor) {
        guard let textfield = self.value(forKey: "searchField") as? UITextField else { return }
            textfield.textColor = UIColor.white
    }
}


