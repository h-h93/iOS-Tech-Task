//
//  LoginViewController.swift
//  MoneyBox
//
//  Created by Zeynep Kara on 16.01.2022.
//

import UIKit
import Networking

class LoginViewController: UIViewController, UIScrollViewDelegate {
    // Design Login
    let loginView: LoginView = {
        let view = LoginView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let operation = Operations()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        setupLoginView()
        
    }
    
    func setupLoginView() {
        view.addSubview(loginView)
        loginView.delegate = self
        loginView.scrollView.delegate = self
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
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
                DispatchQueue.main.async {
                    // display the next view
                    self.displayAccountView()
                }
            } else {
                self.displayErrorToUser(error?.localizedDescription ?? "Error. Unable to sign in, please contact us for assistance")
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
    
    // adjust scrollview for keyboard
    @objc func adjustForKeyboard(notification: Notification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }

        let keyboardScreenEndFrame = keyboardValue.cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)

        if notification.name == UIResponder.keyboardWillHideNotification {
            loginView.scrollView.contentInset = .zero
        } else {
            loginView.scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height - view.safeAreaInsets.bottom, right: 0)
        }

        loginView.scrollView.scrollIndicatorInsets = loginView.scrollView.contentInset
    }
    
}
