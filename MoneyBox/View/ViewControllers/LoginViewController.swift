//
//  LoginViewController.swift
//  MoneyBox
//
//  Created by Zeynep Kara on 16.01.2022.
//

import UIKit
import Networking

class LoginViewController: UIViewController{
    // Design Login
    let loginView: LoginView = {
        let view = LoginView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let operation = Operations()
    
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
        
        loginView.scrollView.loginButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
    }
    
    @objc func loginTapped() {
        let valid = loginView.verifyEmailPassword()
        if valid {
            loginUser()
            loginView.scrollView.loginButton.isEnabled = false
            loginView.scrollView.loginButton.startActivitySpinner()
            // disable login tap for 5 seconds as we try to log the user in
            // in the interim show them an animation spinner to let them know we are working in the background
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                self.loginView.scrollView.loginButton.isEnabled = true
                self.loginView.scrollView.loginButton.stopActivitySpinner()
            }
        }
    }

    
    // log the user into their account
    func loginUser() {
        guard let email = loginView.scrollView.emailTextField.text else { displayErrorToUser("Email not valid")
            return }
        guard let password = loginView.scrollView.passwordTextField.text else { displayErrorToUser("Password not valid")
            return }
        
        operation.loginUser(email: email, password: password) { success, error in
            if success {
                // display the next view
                self.displayAccountView()
            } else {
                self.displayErrorToUser(error?.localizedDescription ?? "Error unable to sign in, Please contact us for assistance")
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
        // let's get started on pulling in the account data so we can minimise any delays
        let rootNC = UINavigationController(rootViewController: vc)
        rootNC.modalPresentationStyle = .fullScreen
        rootNC.modalTransitionStyle = .flipHorizontal
        present(rootNC, animated: true)
    }
    
}
