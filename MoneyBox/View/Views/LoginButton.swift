//
//  LoginButton.swift
//  GlobeTales
//
//  Created by hanif hussain on 14/02/2024.
//

import UIKit

class LoginButton: UIButton {

    let activitySpinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.style = .medium
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.color = .white
        return spinner
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setTitle("Login", for: .normal)
        self.setTitle("", for: .disabled)
        self.setTitleColor(.white, for: .normal)
        self.layer.cornerRadius = 4
        self.backgroundColor = .red
        setup()
    }
    
    func setup() {
        addSubview(activitySpinner)
        
        NSLayoutConstraint.activate([
            activitySpinner.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            activitySpinner.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startActivitySpinner() {
        activitySpinner.startAnimating()
    }
    
    func stopActivitySpinner() {
        activitySpinner.stopAnimating()
    }
    
}
