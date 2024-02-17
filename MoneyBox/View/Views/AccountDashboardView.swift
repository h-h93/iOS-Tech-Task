//
//  AccountDashboardView.swift
//  MoneyBox
//
//  Created by hanif hussain on 16/02/2024.
//

import UIKit
import Networking
import DGCharts

class AccountDashboardView: UIScrollView, UICollectionViewDelegate, UICollectionViewDataSource {
    var pieChart: CustomPieChartView = {
        let pie = CustomPieChartView()
        pie.translatesAutoresizingMaskIntoConstraints = false
        pie.backgroundColor = .clear
        return pie
    }()
    
    let collectionView: AccountListView = {
        let collection = AccountListView()
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()

    var dataProvider = DataProvider()
    
    var label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        // we'll stop showing the scroll indicator so that it doesn't cause confusion as we have a collection view in a scroll view
        self.showsHorizontalScrollIndicator = false
        self.showsVerticalScrollIndicator = false
        getAccountData()
        setupPieView()
        setupCollectionView()
    }
    
    func setupPieView() {
        self.addSubview(pieChart)
        NSLayoutConstraint.activate([
            pieChart.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            pieChart.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            pieChart.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            pieChart.heightAnchor.constraint(greaterThanOrEqualToConstant: 300),
            pieChart.heightAnchor.constraint(lessThanOrEqualToConstant: 400),
            pieChart.widthAnchor.constraint(equalTo: self.widthAnchor)
        ])
    }
    
    func setupCollectionView() {
        collectionView.collectionView.delegate = self
        collectionView.collectionView.dataSource = self
        self.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: pieChart.bottomAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            collectionView.heightAnchor.constraint(equalToConstant: 300),
            
        ])
    }
    
    // grab the users account data to display
    func getAccountData() {
        dataProvider.fetchProducts { response in
            switch response {
            case .success(let success):
                // push to main to create seamless experience 
                DispatchQueue.main.async {
                    // feed accounts into pie chart
                    self.pieChart.account = success.accounts!
                    self.pieChart.accountTotal = success.totalPlanValue ?? 0
                    self.pieChart.setupPieChart()
                }
            case .failure(let error):
                print("failure \(error.localizedDescription)")
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateChartData() {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        cell.backgroundColor = .blue
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
}
