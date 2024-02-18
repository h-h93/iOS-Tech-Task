//
//  GrowthChartView.swift
//  MoneyBox
//
//  Created by hanif hussain on 17/02/2024.
//

import UIKit
import DGCharts
import Networking

class GrowthChartView: UIView {
    // create our line chart
    var lineChartView: LineChartView = {
        let chart = LineChartView()
        chart.translatesAutoresizingMaskIntoConstraints = false
        chart.animate(xAxisDuration: 1, yAxisDuration: 2, easingOption: .easeInCirc)
        return chart
    }()
    // Hold data points
    var lineChartDataEntry = [ChartDataEntry]()
    // get account info to populate graph
    var account: Account!
    var product: ProductResponse!
    
    // track how many since account was created
    var year = [Int]()
    // caputre how much growth of account
    var money = [Int]()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(lineChartView)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            lineChartView.topAnchor.constraint(equalTo: self.topAnchor),
            lineChartView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            lineChartView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            lineChartView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    func setupchartData() {
        // get the date the account was created
        let creationDate = Date().dateFromString(product.dateCreated!)!
        // create date formatter and only get year
        let form = DateComponentsFormatter()
        form.maximumUnitCount = 2
        form.unitsStyle = .full
        form.allowedUnits = [.year]
        
        if #available(iOS 15, *) {
            //let fiveYearsAgoDate = Calendar.current.date(byAdding: .year, value: -5, to: Date())!
            // work out how many years have passed since creation date of account
            let s = form.string(from: creationDate, to: .now) ?? "1"
            let yearDiff = Int(s) ?? 1
            for i in 1...yearDiff {
                year.append(i)
            }
            // if account has no value then provide zero so we can draw chart
            let value = Int(product.planValue ?? 0)
            money.append(value)
            addChartEntry()
        } else {
            // Fallback on earlier versions
            let s = form.string(from: creationDate, to: Date().getCurrentDatePreIos15())
        }
    }
    
    func addChartEntry() {
        // start off our graph from year 0 and value 0 so we can have a baseline on our chart
        let initialDataPoint = ChartDataEntry(x: Double(0), y: (0))
        lineChartDataEntry.append(initialDataPoint)
            for i in year {
                let dataPoint = ChartDataEntry(x: Double(i), y: Double(money.first!))
                lineChartDataEntry.append(dataPoint)
            }
        // customise x axis of chart
        lineChartView.xAxis.labelPosition = .bottom
        lineChartView.xAxis.labelFont = UIFont(name: "AvenirNext-Medium", size: 15)!
        lineChartView.xAxis.axisLineColor = .clear
        lineChartView.xAxis.drawGridLinesEnabled = false // true if you want X-Axis grid lines
        lineChartView.legend.enabled = true
        // disable or enable right or left axis
        lineChartView.rightAxis.enabled = true
        lineChartView.leftAxis.enabled = false
        
        lineChartView.rightAxis.drawGridLinesEnabled = false // true if you want Y-Axis grid lines
        lineChartView.rightAxis.axisLineColor = .clear
        lineChartView.rightAxis.labelPosition = .outsideChart
        lineChartView.rightAxis.labelFont = UIFont(name: "AvenirNext-Medium", size: 15)!
        lineChartView.setScaleEnabled(true)
        
        let line1 = LineChartDataSet(entries: lineChartDataEntry, label: "Growth since inception") //Here we convert lineChartEntry to a LineChartDataSet
        // Gradient fill
        let gradientColors = [ChartColorTemplates.colorFromString("#2ad8ca").cgColor, UIColor.systemGreen.cgColor]
        let gradient = CGGradient(colorsSpace: nil, colors: gradientColors as CFArray, locations: nil)!

        line1.fillAlpha = 1
        line1.fill = LinearGradientFill(gradient: gradient, angle: 90)
        line1.drawFilledEnabled = true

        let data = LineChartData(dataSet: line1) //This is the object that will be added to the chart
        lineChartView.data = data //finally - it adds the chart data to the chart and causes an update
        //lineChartView.chartDescription.text = "Growth chart" // Here we set the title for the graph
    }
}
