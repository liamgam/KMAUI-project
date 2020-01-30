//
//  KMAUIIncomeChartTableViewCell.swift
//  KMA
//
//  Created by Stanislav Rastvorov on 29.01.2020.
//  Copyright © 2020 Office Mac. All rights reserved.
//

import UIKit
import Charts

public class KMAUIIncomeChartTableViewCell: UITableViewCell {
    // MARK: - IBOutlets
    @IBOutlet public weak var titleLabel: KMAUIBoldTextLabel!
    @IBOutlet public weak var incomeChart: BarChartView!
    
    // MARK: - Variables
    public static let id = "KMAUIIncomeChartTableViewCell"
    public weak var axisFormatDelegate: IAxisValueFormatter?
    public var incomeData = [KMAUIIncomeData]() {
        didSet {
            setupCell()
        }
    }
    
//    public let cityArray = ["Birmingham", "Dudley", "Walsall", "Khaybar", "Wolverhampton", "Stourbridge"]
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        
        // Set the title font
        titleLabel.font = KMAUIConstants.shared.KMAUIBoldFont.withSize(18)
        
        // No selection required
        selectionStyle = .none
    }
    
    override public func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    public func setupCell() {
        incomeChart.doubleTapToZoomEnabled = false
        incomeChart.legend.enabled = false
        incomeChart.noDataTextColor = KMAUIConstants.shared.KMATextColor
        
        // Setting the delegate connection for axis
        axisFormatDelegate = self
        
//        let incomeArray = [22000, 14000, 21000, 10000, 28000, 17000]
        
        let xAxis = incomeChart.xAxis
        xAxis.drawAxisLineEnabled = true
        xAxis.drawGridLinesEnabled = false
        xAxis.labelPosition = .bottom
        xAxis.valueFormatter = axisFormatDelegate
        xAxis.labelTextColor = KMAUIConstants.shared.KMATextColor
        xAxis.labelFont = KMAUIConstants.shared.KMAUIRegularFont
        //
        let leftAxis = incomeChart.leftAxis
        leftAxis.drawAxisLineEnabled = false
        leftAxis.drawGridLinesEnabled = true
        leftAxis.drawLabelsEnabled = true
        
        leftAxis.axisMinimum = 0
        leftAxis.axisMaximum = 40000
        
        leftAxis.valueFormatter = KMAYValueFormatter()
        leftAxis.labelTextColor = KMAUIConstants.shared.KMATextColor
        leftAxis.labelFont = KMAUIConstants.shared.KMAUIRegularFont
        
        let rightAxis = incomeChart.rightAxis
        rightAxis.drawAxisLineEnabled = false
        rightAxis.drawGridLinesEnabled = false
        rightAxis.drawLabelsEnabled = false
        
        var yVals = [BarChartDataEntry]()
        
        for (index, item) in incomeData.enumerated() {
            yVals.append(BarChartDataEntry(x: Double(index), y: Double(item.itemIncome)))
        }
        
        let set = BarChartDataSet(entries: yVals, label: "Age distribution")
        set.colors = ChartColorTemplates.colorful()
        set.drawValuesEnabled = false

        let data = BarChartData(dataSet: set)
        data.setValueFont(.systemFont(ofSize: 12, weight: .regular))
        
        data.barWidth = 0.5
        data.highlightEnabled = false
        incomeChart.data = data
        
        incomeChart.notifyDataSetChanged()
    }
}

extension KMAUIIncomeChartTableViewCell: IAxisValueFormatter {
    
    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        if incomeData.count > Int(value) {
            let incomeItem = incomeData[Int(value)]
            
            return incomeItem.itemName
        }
        
        return ""
    }
}

public final class KMAYValueFormatter: IAxisValueFormatter {
    
    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return "\(Int(value / 1000)) k"
    }
}
