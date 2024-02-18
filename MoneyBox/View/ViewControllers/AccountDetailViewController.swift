//
//  AccountDetailViewController.swift
//  MoneyBox
//
//  Created by hanif hussain on 16/02/2024.
//

import UIKit
import Networking

class AccountDetailViewController: UIViewController {
    var account: Account!
    var product: ProductResponse!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupAccountView()
    }
    
    func setupAccountView() {
        let accountView = AccountDetailView()
        accountView.translatesAutoresizingMaskIntoConstraints = false
        accountView.account = self.account
        accountView.product = self.product
        accountView.setupchartData()
        view.addSubview(accountView)
        NSLayoutConstraint.activate([
            accountView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            accountView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            accountView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            accountView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

}
