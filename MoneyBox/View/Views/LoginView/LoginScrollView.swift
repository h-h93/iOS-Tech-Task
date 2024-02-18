//
//  LoginScrollView.swift
//  MoneyBox
//
//  Created by hanif hussain on 18/02/2024.
//

import UIKit

class LoginScrollView: UIScrollView {
    //-------------------------------- start declare UI components ---------------------------------//
    var emailTextField: EmailTextField = {
        let textField = EmailTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.tag = 1
        return textField
    }()
    
    var passwordTextField: PasswordTextField = {
        let textField = PasswordTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.tag = 2
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
        label.text = "Sign in to Moneybox"
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
    //-------------------------------- end declare UI components ---------------------------------//

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
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
        // use our custom extension to return a string that colours in a specific word
        signUpLabel.colorString(text: "Don't have an account? Sign up", coloredText: "Sign up", color: .systemBlue)
        self.addSubview(signUpLabel)
        
        setConstraints()
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            loginTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            loginTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            loginTitle.heightAnchor.constraint(equalToConstant: 50),
            loginTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            emailLabel.topAnchor.constraint(equalTo: loginTitle.bottomAnchor, constant: 50),
            emailLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            emailLabel.heightAnchor.constraint(equalToConstant: 20),
            emailLabel.widthAnchor.constraint(equalTo: self.widthAnchor),
            
            emailTextField.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 20),
            emailTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            emailTextField.heightAnchor.constraint(lessThanOrEqualToConstant: 80),
            emailTextField.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -20),

            passwordLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 60),
            passwordLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            passwordLabel.heightAnchor.constraint(equalToConstant: 20),
            passwordLabel.widthAnchor.constraint(equalTo: self.widthAnchor),
            
            passwordTextField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 20),
            passwordTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            passwordTextField.heightAnchor.constraint(lessThanOrEqualToConstant: 80),
            passwordTextField.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -20),
            
            resetPasswordLabel.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            resetPasswordLabel.heightAnchor.constraint(equalToConstant: 50),
            resetPasswordLabel.widthAnchor.constraint(equalToConstant: 150),
            resetPasswordLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            
            
            loginButton.topAnchor.constraint(equalTo: resetPasswordLabel.bottomAnchor, constant: 70),
            loginButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 50),
            loginButton.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -100),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            
            signUpLabel.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 100),
            signUpLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            signUpLabel.widthAnchor.constraint(equalToConstant: 250),
            signUpLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
        ])
    }
}
