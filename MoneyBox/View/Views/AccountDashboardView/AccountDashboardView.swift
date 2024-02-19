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
    // a pie chart for some visual information to display to user
    var pieChart: CustomPieChartView = {
        let pie = CustomPieChartView()
        pie.translatesAutoresizingMaskIntoConstraints = false
        pie.backgroundColor = .clear
        return pie
    }()
    // our custom collection view to show list of users accounts
    let collectionView: CollectionViewAccountListView = {
        let collection = CollectionViewAccountListView()
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    // loading animation view
    let loadingAnimationView: LoadingAnimationView = {
        let view = LoadingAnimationView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let operations = Operations()
    
    // hold our users account data for display
    var accountRespone: AccountResponse!
    var accounts = [Account]()
    var product = [ProductResponse]()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.backgroundColor = .clear
        // we'll stop showing the scroll indicator so that it doesn't cause confusion as we have a collection view in a scroll view
        self.showsHorizontalScrollIndicator = false
        self.showsVerticalScrollIndicator = false
        setupPieView()
        setupCollectionView()
        
        // add and start the loading animation so user knows we are getting their data
        setupAnimationView()
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
    
    // setup the loading animation view
    func setupAnimationView() {
        self.addSubview(loadingAnimationView)
        NSLayoutConstraint.activate([
            loadingAnimationView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            loadingAnimationView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            loadingAnimationView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            loadingAnimationView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
        ])
        loadingAnimationView.setupAnimation()
    }
    
    // stop the animation from playing
    @objc func stopAnimation() {
        loadingAnimationView.animationView?.stop()
        loadingAnimationView.removeFromSuperview()
    }
    
    // grab the users account data to display
    func getData() {
        pieChart.accountData.removeAll() // remove all current datapoints to redraw correctly
        operations.getAccountData { response, error in
            if error == nil {
                self.accountRespone = response
                self.accounts = response!.accounts!
                self.product = response!.productResponses!
                NotificationCenter.default.post(name: NSNotification.Name("com.accountDataRetrieved"), object: nil)
                self.updateCollectionView()
                self.drawPieChart()
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
        // feed accounts to collection view
        self.collectionView.account = accounts
        self.collectionView.productResponse = product
        self.collectionView.collectionView.reloadData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
