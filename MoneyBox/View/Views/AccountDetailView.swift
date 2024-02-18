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
    var lineChartView: LineChartView = {
        let chart = LineChartView()
        chart.translatesAutoresizingMaskIntoConstraints = false
        chart.animate(xAxisDuration: 3, yAxisDuration: 3, easingOption: .easeInSine)
        return chart
    }()
    
    var account: Account!
    var product: ProductResponse!
    
    var lineChartDataEntry = [ChartDataEntry]()
    
    var year = [Int]()
    var money = [Double]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.showsHorizontalScrollIndicator = false
        self.showsVerticalScrollIndicator = false
        setupChart()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupChart() {
        self.addSubview(lineChartView)
        
        NSLayoutConstraint.activate([
            lineChartView.topAnchor.constraint(equalTo: self.topAnchor),
            lineChartView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            lineChartView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            lineChartView.widthAnchor.constraint(equalTo: self.widthAnchor),
            lineChartView.heightAnchor.constraint(equalToConstant: 300),
            
        ])
    }
    
    func setupchartData() {
        // create our number formatter to transform number into 2 decimal places
        let format = NumberFormatter()
        format.numberStyle = .decimal
        format.minimumFractionDigits = 2
        format.maximumFractionDigits = 2
        format.zeroSymbol = ""
        
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
            let value = product.planValue ?? 0
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

        lineChartView.xAxis.labelPosition = .bottom
        lineChartView.xAxis.drawGridLinesEnabled = false // true if want X-Axis grid lines
        lineChartView.legend.enabled = true
        lineChartView.rightAxis.enabled = false
        lineChartView.leftAxis.drawGridLinesEnabled = false // true if want Y-Axis grid lines
        lineChartView.xAxis.axisLineColor = .clear
        lineChartView.leftAxis.drawLabelsEnabled = true
        lineChartView.xAxis.enabled = false
        
        let line1 = LineChartDataSet(entries: lineChartDataEntry, label: "Growth") //Here we convert lineChartEntry to a LineChartDataSet
        // Gradient fill
        let gradientColors = [ChartColorTemplates.colorFromString("#00ff0000").cgColor,
                              ChartColorTemplates.colorFromString("#ffff0000").cgColor]
        let gradient = CGGradient(colorsSpace: nil, colors: gradientColors as CFArray, locations: nil)!

        line1.fillAlpha = 1
        line1.fill = LinearGradientFill(gradient: gradient, angle: 90)
        line1.drawFilledEnabled = true
            
        //line1.colors = [.random] //Sets the colour to blue
        let data = LineChartData(dataSet: line1) //This is the object that will be added to the chart
        lineChartView.data = data //finally - it adds the chart data to the chart and causes an update
        lineChartView.chartDescription.text = "My awesome chart" // Here we set the title for the graph
    }
}
