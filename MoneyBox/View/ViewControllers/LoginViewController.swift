//
//  LoginViewController.swift
//  MoneyBox
//
//  Created by Zeynep Kara on 16.01.2022.
//

import UIKit
import Networking

class LoginViewController: UIViewController {
    // Design Login
    let loginView: LoginView = {
        let view = LoginView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLoginView()
        
    }
    
    func setupLoginView() {
        view.addSubview(loginView)
        NSLayoutConstraint.activate([
            loginView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            loginView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            loginView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            loginView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        loginView.loginButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
    }
    
    @objc func loginTapped() {
        loginUser()
        loginView.loginButton.isEnabled = false
        loginView.loginButton.startActivitySpinner()
        // disable login tap for 3 seconds as we try to log the user in
        // in the interim time show them an animation spinner to let them know we are working in the background
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.loginView.loginButton.isEnabled = true
            self.loginView.loginButton.stopActivitySpinner()
        }
    }
    
    func loginUser() {
        let dataProvider = DataProvider()
        // modify this to take email text and password text and handle errors
        let request = Networking.LoginRequest(email: "test+ios2@moneyboxapp.com", password: "P455word12")
        dataProvider.login(request: request) { result in
            switch result {
            case .success(let loginResponse):
                print("success \(loginResponse)")
            case .failure(let error):
                print("failure \(error.localizedDescription)")
            }
        }
    }
}
