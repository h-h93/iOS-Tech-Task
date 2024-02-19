//
//  EmailLoginView.swift
//  GlobeTales
//
//  Created by hanif hussain on 14/02/2024.
//

import UIKit

class LoginView: UIView, UITextFieldDelegate {
    var scrollView: LoginScrollView = {
        let view = LoginScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    weak var delegate: LoginViewController!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setupView()
        setViewconstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // add ui components to view and create and implement gesture recognisers
    func setupView() {
        self.addSubview(scrollView)
        // reset password gesture
        let resetGesture = UITapGestureRecognizer(target: self, action: #selector(resetTapped))
        scrollView.resetPasswordLabel.addGestureRecognizer(resetGesture)
        scrollView.signUpLabel.isUserInteractionEnabled = true
        setTextFieldDelegates()
    }
    
    func setTextFieldDelegates() {
        scrollView.emailTextField.delegate = self
        scrollView.passwordTextField.delegate = self
    }
    
    // set our constraints for our subviews
    func setViewconstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    // reset function
    @objc func resetTapped() {
        guard let email = scrollView.emailTextField.text else { return }
        // code to reset password
    }
    
    // hide textfield when done button is tapped
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func verifyEmailPassword() -> Bool {
        guard let email = scrollView.emailTextField.text else { return false }
        guard let password = scrollView.passwordTextField.text else { return false }
        if email.isValidEmail(email) && password.isValidPassword(password) {
            return true
        } else if !email.isValidEmail(email) {
            delegate.displayErrorToUser("Email not valid")
            return false
        } else if !password.isValidPassword(password) {
            delegate.displayErrorToUser("Password not valid, Password must be 8 characters long and must contain at least one Capital letter and a number")
            return false
        } else {
            return false
        }
    }
    
}
