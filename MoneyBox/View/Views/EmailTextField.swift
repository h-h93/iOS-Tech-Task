//
//  EmailTextField.swift
//  MoneyBox
//
//  Created by hanif hussain on 15/02/2024.
//

import UIKit

class EmailTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addBottomBorder()
        self.backgroundColor = .white
        self.leftViewMode = .unlessEditing
        self.leftView = UIImageView(image: UIImage(systemName: "envelope.fill"))
        self.textColor = .black
        self.autocorrectionType = .no
        self.keyboardType = .emailAddress
        self.returnKeyType = .done
        self.autocapitalizationType = .none
        self.attributedPlaceholder = NSAttributedString(string: "Enter email address", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
