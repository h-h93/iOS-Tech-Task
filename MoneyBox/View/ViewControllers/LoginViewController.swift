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
    
    let dataProvider = DataProvider()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLoginView()
        
    }
    
    func setupLoginView() {
        view.addSubview(loginView)
        loginView.delegate = self
        NSLayoutConstraint.activate([
            loginView.topAnchor.constraint(equalTo: view.topAnchor),
            loginView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            loginView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            loginView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        loginView.loginButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
    }
    
    @objc func loginTapped() {
        let valid = loginView.verifyEmailPassword()
        if valid {
            // set this back to loginUser() it is only for testing
            loginUserQuickly()
            loginView.loginButton.isEnabled = false
            loginView.loginButton.startActivitySpinner()
            // disable login tap for 3 seconds as we try to log the user in
            // in the interim show them an animation spinner to let them know we are working in the background
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                self.loginView.loginButton.isEnabled = true
                self.loginView.loginButton.stopActivitySpinner()
            }
        }
    }
    // log the user into their account
    func loginUser() {
        guard let email = loginView.emailTextField.text else { displayErrorToUser("Email not valid")
            return }
        guard let password = loginView.passwordTextField.text else { displayErrorToUser("Password not valid")
            return }
        //email: "test+ios2@moneyboxapp.com", password: "P455word12"
        let request = Networking.LoginRequest(email: email, password: password)
        dataProvider.login(request: request) { result in
            switch result {
            case .success(let loginResponse):
                // get and store bearer token
                Networking.Authentication.token = loginResponse.session.bearerToken
                self.displayAccountView()
            case .failure(let error):
                // let's show the error to the user
                self.displayErrorToUser(error.localizedDescription)
            }
        }
    }
    
    // log the user into their account
    func loginUserQuickly() {
        //email: "test+ios2@moneyboxapp.com", password: "P455word12"
        let request = Networking.LoginRequest(email: "test+ios2@moneyboxapp.com", password: "P455word12")
        dataProvider.login(request: request) { result in
            switch result {
            case .success(let loginResponse):
                // get and store bearer token
                Networking.Authentication.token = loginResponse.session.bearerToken
                self.displayAccountView()
            case .failure(let error):
                // let's show the error to the user
                self.displayErrorToUser(error.localizedDescription)
            }
        }
    }
    
    // display error message to user
    func displayErrorToUser(_ errorString: String) {
        let ac = UIAlertController(title: "Unable to sign you in", message: errorString, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(ac, animated: true)
    }
    
    
    // navigate to users account view
    func displayAccountView() {
        let vc = AccountsDashboardViewController()
        let rootNC = UINavigationController(rootViewController: vc)
        rootNC.modalPresentationStyle = .fullScreen
        rootNC.modalTransitionStyle = .flipHorizontal
        present(rootNC, animated: true)
    }
    
}
