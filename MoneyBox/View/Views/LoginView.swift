//
//  EmailLoginView.swift
//  GlobeTales
//
//  Created by hanif hussain on 14/02/2024.
//

import UIKit

class LoginView: UIView, UITextFieldDelegate {
    
    var emailTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.tag = 1
        textField.addBottomBorder()
        textField.backgroundColor = .white
        textField.textColor = .black
        textField.autocorrectionType = .no
        textField.keyboardType = .emailAddress
        textField.autocapitalizationType = .none
        textField.attributedPlaceholder = NSAttributedString(string: "Enter email address", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        return textField
    }()
    
    var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.tag = 2
        textField.addBottomBorder()
        textField.backgroundColor = .white
        textField.textColor = .black
        textField.autocorrectionType = .no
        textField.isSecureTextEntry = true
        textField.autocapitalizationType = .none
        textField.attributedPlaceholder = NSAttributedString(string: "Enter password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        return textField
    }()
    
    let emailLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Email: "
        label.font = UIFont(name: "AvenirNext-Medium", size: 16)
        label.textAlignment = .left
        label.textColor = .black
        return label
    }()
    
    let passwordLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.text = "Password: "
        label.font = UIFont(name: "AvenirNext-Medium", size: 16)
        label.textColor = .black
        return label
    }()
    
    let resetPasswordLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = true
        label.textAlignment = .left
        label.text = "Forgot password?"
        label.font = UIFont(name: "AvenirNext-Medium", size: 14)
        label.textColor = .systemBlue
        return label
    }()
    
    let loginTitle: UILabel = {
        let label = UILabel()
        label.text = "Login"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "AvenirNext-Medium", size: 30)
        label.textColor = .black
        return label
    }()
    
    var signUpLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "AvenirNext-Medium", size: 16)
        label.textColor = .black
        return label
    }()
    
    var loginButton: LoginButton = {
        let button = LoginButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setupView()
        setViewconstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        self.addSubview(loginTitle)
        self.addSubview(emailLabel)
        self.addSubview(emailTextField)
        self.addSubview(passwordLabel)
        self.addSubview(passwordTextField)
        self.addSubview(resetPasswordLabel)
        self.addSubview(loginButton)
        signUpLabel.colorString(text: "Don't have an account? Sign up", coloredText: "Sign up")
        self.addSubview(signUpLabel)
        
        // reset password gesture
        let resetGesture = UITapGestureRecognizer(target: self, action: #selector(resetTapped))
        resetPasswordLabel.addGestureRecognizer(resetGesture)
        signUpLabel.isUserInteractionEnabled = true
        setTextFieldDelegates()
    }
    
    func setTextFieldDelegates() {
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    func setViewconstraints() {
        NSLayoutConstraint.activate([
            loginTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: 50),
            loginTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            loginTitle.heightAnchor.constraint(equalToConstant: 50),
            loginTitle.widthAnchor.constraint(equalToConstant: 200),
            
            emailLabel.topAnchor.constraint(equalTo: loginTitle.bottomAnchor, constant: 40),
            emailLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            emailLabel.heightAnchor.constraint(equalToConstant: 20),
            emailLabel.widthAnchor.constraint(equalToConstant: 50),
            
            emailTextField.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 5),
            emailTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            emailTextField.heightAnchor.constraint(lessThanOrEqualToConstant: 80),
            emailTextField.heightAnchor.constraint(greaterThanOrEqualToConstant: 50),
            emailTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),

            passwordLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 50),
            passwordLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            passwordLabel.heightAnchor.constraint(equalToConstant: 20),
            passwordLabel.widthAnchor.constraint(equalToConstant: 100),
            
            passwordTextField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 5),
            passwordTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            passwordTextField.heightAnchor.constraint(lessThanOrEqualToConstant: 80),
            passwordTextField.heightAnchor.constraint(greaterThanOrEqualToConstant: 50),
            passwordTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            
            resetPasswordLabel.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor),
            resetPasswordLabel.leadingAnchor.constraint(equalTo: self.trailingAnchor, constant: -150),
            resetPasswordLabel.heightAnchor.constraint(equalToConstant: 50),
            resetPasswordLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            loginButton.topAnchor.constraint(equalTo: resetPasswordLabel.bottomAnchor, constant: 30),
            loginButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            loginButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15),
            loginButton.heightAnchor.constraint(greaterThanOrEqualToConstant: 50),
            loginButton.heightAnchor.constraint(lessThanOrEqualToConstant: 80),
            
            //signUpLabel.topAnchor.constraint(equalTo: self.bottomAnchor, constant: -30),
            signUpLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            signUpLabel.heightAnchor.constraint(equalToConstant: 25),
            signUpLabel.widthAnchor.constraint(equalToConstant: 250),
            signUpLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10)
        ])
    }

    @objc func resetTapped() {
        guard let email = emailTextField.text else { return }
        // code to reset password
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    

}
