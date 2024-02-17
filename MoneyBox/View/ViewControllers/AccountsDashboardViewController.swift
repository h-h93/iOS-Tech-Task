//
//  AccountsDashboardViewController.swift
//  MoneyBox
//
//  Created by hanif hussain on 15/02/2024.
//

import UIKit
import Networking

class AccountsDashboardViewController: UIViewController, UIScrollViewDelegate {
    let accountDashboardView: AccountDashboardView = {
        let view = AccountDashboardView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupView()
    }
    
    func setupView() {
        accountDashboardView.delegate = self
        accountDashboardView.contentSize = CGSize(width: view.frame.size.width, height: 600)
        view.addSubview(accountDashboardView)
        setConstraints()
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            accountDashboardView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            accountDashboardView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            accountDashboardView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            accountDashboardView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -15)
        ])
    }
    
    // disable scrolling horizontally
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x != 0 {
            scrollView.contentOffset.x = 0
        }
    }

}
