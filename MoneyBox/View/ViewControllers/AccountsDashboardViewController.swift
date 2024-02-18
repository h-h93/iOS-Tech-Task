//
//  AccountsDashboardViewController.swift
//  MoneyBox
//
//  Created by hanif hussain on 15/02/2024.
//

import UIKit
import Networking

class AccountsDashboardViewController: UIViewController {
    let accountDashboardView: AccountDashboardView = {
        let view = AccountDashboardView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        DispatchQueue.main.async {
            self.accountDashboardView.getData()
        }
        setupView()
    }
    
    func setupView() {
        view.addSubview(accountDashboardView)
        // assign our view controller to delegate so we can navigate to the next view
        accountDashboardView.collectionView.delegate = self
        setConstraints()
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            accountDashboardView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            accountDashboardView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            accountDashboardView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            accountDashboardView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func showAccountDetailViewController(account: Account, product: ProductResponse) {
        let vc = AccountDetailViewController()
        vc.account = account
        vc.product = product
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // disable scrolling horizontally
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x != 0 {
            scrollView.contentOffset.x = 0
        }
    }

}
