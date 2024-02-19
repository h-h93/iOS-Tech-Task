//
//  AccountsDashboardViewController.swift
//  MoneyBox
//
//  Created by hanif hussain on 15/02/2024.
//

import UIKit
import Networking
import Lottie

class AccountsDashboardViewController: UIViewController {
    let accountDashboardView: AccountDashboardView = {
        let view = AccountDashboardView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // set up dashboard view
        setupAccountDashboardView()
        
        // let's listen out for when data is retrieved successfully
        NotificationCenter.default.addObserver(self, selector: #selector(stopAnimation), name: NSNotification.Name("com.accountDataRetrieved"), object: nil)
        
        // let's listen out for when money is added so we can update our ui
        NotificationCenter.default.addObserver(self, selector: #selector(reloadData), name:Notification.Name("com.moneyAdded"), object: nil)
        // give a second or two delay before we present to counter the fact it will take sec to grab data
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.accountDashboardView.getData()
        }
    }
    
    func setupAccountDashboardView() {
        view.addSubview(accountDashboardView)
        // assign our view controller to delegate so we can navigate to the next view
        accountDashboardView.collectionView.delegate = self
        
        NSLayoutConstraint.activate([
            accountDashboardView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            accountDashboardView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            accountDashboardView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            accountDashboardView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
    }
    
    // stop the animation from playing
    @objc func stopAnimation() {
        accountDashboardView.stopAnimation()
    }
    
    @objc func reloadData() {
        accountDashboardView.getData()
    }
    
    func showAccountDetailViewController(account: Account, product: ProductResponse, index: Int) {
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
