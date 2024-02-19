//
//  AccountListView.swift
//  MoneyBox
//
//  Created by hanif hussain on 17/02/2024.
//

import UIKit
import Networking

class AccountDetailCollectionView: UIView, UICollectionViewDelegate, UICollectionViewDataSource {
    var collectionView: UICollectionView!
    
    var account: Account!
    var product: ProductResponse!
    
    // create a delegate so we can notify the main view controller when the user adds money to the account
    weak var delegate: AccountDetailViewController!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCollectionVew()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCollectionVew() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: getCompositionalLayout())
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CustomAccountDetailCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    // create a compositional layout horizontally taking up full width of screen with padding
    func getCompositionalLayout() -> UICollectionViewCompositionalLayout {
        let topPanel = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        topPanel.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 20, bottom: 5, trailing: 20)
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)), subitems: [topPanel])
        
        //--------- Container Group ---------//
        let containerGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)), subitems: [group])
        let section = NSCollectionLayoutSection(group: containerGroup)
            
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CustomAccountDetailCollectionViewCell
        cell.accountNameLabel.text = "\(account.name!)"
        cell.planValueLabel.text = "Plan Value: £\(product.planValue!)"
        cell.moneyBoxAmountLabel.text = "Moneybox: £\(product.moneybox!)"
        // add button action so we can let user top up account
        cell.topUpButton.addTarget(self, action: #selector(topUpTapped), for: .touchUpInside)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    @objc func topUpTapped() {
        delegate.addMoneyToAccount()
    }
}
