//
//  GraphValueFormatter.swift
//  How Are You?
//
//  Created by Zaccari Silverman on 3/19/19.
//  Copyright © 2019 RCOS-HowAreYou. All rights reserved.
//

import Charts

class GraphValueFormatter: IValueFormatter {
    
    //This class helps us format our values; since use integers, not doubles, we can make
    //our values hide their decimal points.
    
    init() {}//This does actually need to be instantiated.
    
    func stringForValue(_ value: Double, entry: ChartDataEntry, dataSetIndex: Int, viewPortHandler: ViewPortHandler?) -> String {
        return String(Int(value))
    }
    
    
}


