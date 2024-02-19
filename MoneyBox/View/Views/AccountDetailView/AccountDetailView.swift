//
//  AccountDetailView.swift
//  MoneyBox
//
//  Created by hanif hussain on 16/02/2024.
//

import UIKit
import DGCharts
import Networking

class AccountDetailView: UIScrollView {
    lazy var operations = Operations()
    var lineChartView: GrowthChartView = {
        let chart = GrowthChartView()
        chart.translatesAutoresizingMaskIntoConstraints = false
        return chart
    }()
    
    var collectionView: AccountDetailCollectionView = {
        let view = AccountDetailCollectionView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var index = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.showsHorizontalScrollIndicator = false
        self.showsVerticalScrollIndicator = false
        setupChart()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupChart() {
        self.addSubview(lineChartView)
        self.addSubview(collectionView)
        NSLayoutConstraint.activate([
            lineChartView.topAnchor.constraint(equalTo: self.topAnchor),
            lineChartView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            lineChartView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            lineChartView.widthAnchor.constraint(equalTo: self.widthAnchor),
            lineChartView.heightAnchor.constraint(equalToConstant: 300),
            
            collectionView.topAnchor.constraint(equalTo: lineChartView.bottomAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            collectionView.heightAnchor.constraint(equalToConstant: 200),
        ])
    }
    
    // grab the users account data to display
    func getData() {
        operations.getAccountData { response, error in
            if error == nil {
                self.collectionView.account = response?.accounts![self.index]
                self.collectionView.product = response?.productResponses![self.index]
                self.lineChartView.account = response?.accounts![self.index]
                self.lineChartView.product = response?.productResponses![self.index]
                NotificationCenter.default.post(name: NSNotification.Name("com.accountDataRetrieved"), object: nil)
                // update collectionView on main
                DispatchQueue.main.async {
                    self.collectionView.collectionView.reloadData()
                    self.lineChartView.setupchartData()
                }
            }
        }
    }
    
    
}
