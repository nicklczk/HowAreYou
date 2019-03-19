//
//  CustomGraphDataPoint.swift
//  How Are You?
//
//  Created by Zaccari Silverman on 3/19/19.
//  Copyright © 2019 RCOS-HowAreYou. All rights reserved.
//

import Charts

class CustomGraphDataPoint: ChartDataEntry {
    let dateString : String!
    let notes : String!
    
    
    init(x: Double, y: Double, dateString: String, notes : String) {
        self.dateString = dateString
        self.notes = notes
        super.init(x: x, y: y)
    }
    
    //Swift gets mad if this isn't here.
    required init() {
        dateString = "Unknown Date"
        notes = "No notes."
        super.init()
    }
    
}
