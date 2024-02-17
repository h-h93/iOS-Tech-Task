//
//  AccountDashboardView.swift
//  MoneyBox
//
//  Created by hanif hussain on 16/02/2024.
//

import UIKit
import Networking
import DGCharts

class AccountDashboardView: UIScrollView {
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
    
    let operations = Operations()
    
    var accountRespone: AccountResponse!
    var accounts = [Account]()
    var product = [ProductResponse]()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        // we'll stop showing the scroll indicator so that it doesn't cause confusion as we have a collection view in a scroll view
        self.showsHorizontalScrollIndicator = false
        self.showsVerticalScrollIndicator = false
        
        setupPieView()
        setupCollectionView()
    }
    // setup and apply constraints to pie chart view
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
    // setup and apply constraints to collection view
    func setupCollectionView() {
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
    func getData() {
        operations.getAccountData { response, error in
            if error == nil {
                self.accountRespone = response
                self.accounts = response!.accounts!
                self.product = response!.productResponses!
                DispatchQueue.main.async {
                    self.updateCollectionView()
                    self.drawPieChart()
                }
            }
        }
    }
    
    func drawPieChart() {
        // feed accounts into pie chart
        self.pieChart.account = accounts
        // the user may not have contributed money to the account so we will apply nil coalescing
        self.pieChart.accountTotal = accountRespone.totalPlanValue ?? 0
        self.pieChart.setupPieChart()
    }
    
    func updateCollectionView() {
        self.collectionView.account = accounts
        self.collectionView.productResponse = product
        self.collectionView.collectionView.reloadData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateChartData() {
        
    }
    
}
