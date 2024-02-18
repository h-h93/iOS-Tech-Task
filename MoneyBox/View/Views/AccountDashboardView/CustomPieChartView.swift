//
//  PieChartView.swift
//  MoneyBox
//
//  Created by hanif hussain on 16/02/2024.
//

import UIKit
import DGCharts
import Networking

class CustomPieChartView: UIView, ChartViewDelegate {
    
    var pieChart: PieChartView = {
        let pie = PieChartView()
        pie.translatesAutoresizingMaskIntoConstraints = false
        pie.entryLabelFont = UIFont(name: "AvenirNext-Medium", size: 15)!
        pie.centerText = "Account"
        pie.rotationEnabled = true
        // animate our pie chart so it looks nicer and adds a bit of character to our app
        pie.animate(xAxisDuration: 5, yAxisDuration: 4)
        return pie
    }()
    var account = [Account]()
    var colourPallete = [ChartColorTemplates.colorFromString("#2ad8ca").cgColor, ChartColorTemplates.colorFromString("#D8D2E1").cgColor, ChartColorTemplates.colorFromString("#F9DEC9").cgColor, ChartColorTemplates.colorFromString("#E9AFA3").cgColor, ChartColorTemplates.colorFromString("#685044").cgColor]
    var accountData = [PieChartDataEntry]()
    var pieChartAccountColour = [UIColor]()
    
    var accountTotal = 0.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        pieChart.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        self.addSubview(pieChart)
        NSLayoutConstraint.activate([
            pieChart.topAnchor.constraint(equalTo: self.topAnchor),
            pieChart.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            pieChart.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            pieChart.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    func setupPieChart() {
        // create our number formatter to transform our number into a presentable percentage
        let format = NumberFormatter()
            format.numberStyle = .percent
            format.maximumFractionDigits = 0
            format.multiplier = 1.0
            format.percentSymbol = "%"
            format.zeroSymbol = ""
        
        // grab the users account value so we can populate our pie chart
        for (index, value) in account.enumerated() {
            // create data entries for pie chart
            let data = PieChartDataEntry()
            // if the investment account has no funds then set to zero
            data.value = calculatePercentage(value: value.wrapper?.totalValue ?? 0)
            // give the label a name
            data.label = value.name
            accountData.append(data)
            // create a colour for our data
            let colour = UIColor(cgColor: colourPallete[index])
            pieChartAccountColour.append(colour)
        }
        // set the pie chart data set by providing our data entries
        let chartDataSet = PieChartDataSet(entries: accountData, label: "")
        chartDataSet.entryLabelFont = UIFont(name: "AvenirNext-Medium", size: 15)!
        let chartData = PieChartData(dataSet: chartDataSet)
        // apply the formatter to the chart data
        let formatter = DefaultValueFormatter(formatter: format)
        chartData.setValueFormatter(formatter)
        // set the colour of eachsegment of the pie chart to our specified colour
        chartDataSet.colors = pieChartAccountColour
        // assign the data to our pie chart
        pieChart.data = chartData
        // apply the formatter to our pie chart values
        chartData.dataSet?.valueFormatter = formatter
        // set the colour of the text labels that appear on the pie chart
        pieChart.data?.setValueTextColor(.black)
    }
    
    func calculatePercentage(value: Double) -> Double {
        if value > 0 {
            let percentage = value / accountTotal * 100
            return percentage
        } else {
            return 0
        }
    }
    
}
