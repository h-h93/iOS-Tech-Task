//
//  passwordTextField.swift
//  MoneyBox
//
//  Created by hanif hussain on 15/02/2024.
//

import UIKit

class PasswordTextField: UITextField {
    let imageView = UIImageView(image: UIImage(systemName: "eye.slash"))

    override init(frame: CGRect) {
        super.init(frame: frame)
        passwordTextFieldImageTapped()
        self.addBottomBorder()
        self.leftViewMode = .unlessEditing
        self.leftView = imageView
        self.leftView?.isUserInteractionEnabled = true
        self.backgroundColor = .white
        self.textColor = .black
        self.autocorrectionType = .no
        self.isSecureTextEntry = true
        self.autocapitalizationType = .none
        self.returnKeyType = .done
        self.attributedPlaceholder = NSAttributedString(string: "Enter password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        self.passwordTextFieldImageTapped()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // create and assign a tap gesture
    func passwordTextFieldImageTapped() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(displayPasswordText))
        imageView.addGestureRecognizer(tapGesture)
    }
    // toggle to show the password when user click on the eye icon/image
    @objc func displayPasswordText() {
        self.isSecureTextEntry.toggle()
        if self.isSecureTextEntry == false {
            imageView.image = UIImage(systemName: "eye")
        } else {
            imageView.image = UIImage(systemName: "eye.slash")
        }
    }
    
}
