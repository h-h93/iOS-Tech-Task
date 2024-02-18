//
//  AccountDetailViewController.swift
//  MoneyBox
//
//  Created by hanif hussain on 16/02/2024.
//

import UIKit
import Networking

class AccountDetailViewController: UIViewController, UIScrollViewDelegate {
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
        accountView.collectionView.account = self.account
        accountView.collectionView.product = self.product
        accountView.lineChartView.account = self.account
        accountView.lineChartView.product = self.product
        accountView.lineChartView.setupchartData()
        accountView.delegate = self
        view.addSubview(accountView)
        NSLayoutConstraint.activate([
            accountView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            accountView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            accountView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            accountView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    // disable scrolling horizontally
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x != 0 {
            scrollView.contentOffset.x = 0
        }
    }

}
