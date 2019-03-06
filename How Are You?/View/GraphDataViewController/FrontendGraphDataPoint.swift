//
//  FrontendGraphDataPoint.swift
//  How Are You?
//
//  Created by Zaccari Silverman on 3/6/19.
//  Copyright © 2019 RCOS-HowAreYou. All rights reserved.
//

import Foundation

/*This is an intermediate class that will allow short-term storage of fetched GraphDataPoints.*/

class FrontendGraphDataPoint {
    let title : String
    let date : Date
    let phq : Int
    let notes : String
    init(title: String, date: Date, phq: Int, notes: String) {
        self.title = title
        self.date = date
        self.phq = phq
        self.notes = notes
    }
}

//This lets us implement < and > operators. I could have put this inside the above block, but this felt nicer at the time.
extension FrontendGraphDataPoint : Comparable {
    static func < (first: FrontendGraphDataPoint, last: FrontendGraphDataPoint) -> Bool {
        //We only really want these compared based on their dates, so that's how we'll implement the comparators.
        return first.date < last.date
    }
    
    static func > (first: FrontendGraphDataPoint, last: FrontendGraphDataPoint) -> Bool {
        return first.date > last.date
    }
}

extension FrontendGraphDataPoint : Equatable {
    static func == (first: FrontendGraphDataPoint, last: FrontendGraphDataPoint) -> Bool {
        //Similar to the previous block, but for equality.
        return first.date == last.date
    }
}
