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
    let accountView: AccountDetailView = {
        let view = AccountDetailView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    // hold the counter for which account was selected from the array so we can repopulate the data in our view with the correct account
    var accountIndex = 0
    let dataProvider = DataProvider()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupAccountView()
    }
    
    func setupAccountView() {
        accountView.collectionView.account = self.account
        accountView.collectionView.product = self.product
        accountView.lineChartView.account = self.account
        accountView.lineChartView.product = self.product
        // assign self as delegate of collection view so we can register when top up has been tapped
        accountView.collectionView.delegate = self
        accountView.lineChartView.setupchartData()
        accountView.index = accountIndex
        accountView.delegate = self
        view.addSubview(accountView)
        NSLayoutConstraint.activate([
            accountView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            accountView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            accountView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            accountView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    @objc func addMoneyToAccount() {
        let ac = UIAlertController(title: "Are you sure you would like to deposit £10?", message: nil, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        ac.addAction(UIAlertAction(title: "Add", style: .default, handler: { action in
            let request = Networking.OneOffPaymentRequest(amount: 10, investorProductID: self.product.id!)
            self.dataProvider.addMoney(request: request) { result in
                switch result {
                case .success(let success):
                    self.accountView.getData()
                    // notify account dashboard we have successfully added money so reload data
                    NotificationCenter.default.post(name: Notification.Name("com.moneyAdded"), object: nil)
                case .failure(let error):
                    // show error to user
                    self.displayErrorToUser(error.localizedDescription)
                }
            }
        }))
        
        present(ac, animated: true)
    }
    
    // display error message to user
    func displayErrorToUser(_ errorString: String) {
        let ac = UIAlertController(title: "Unable add money to acconut", message: errorString, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(ac, animated: true)
    }
    
    // disable scrolling horizontally
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x != 0 {
            scrollView.contentOffset.x = 0
        }
    }
    
}
