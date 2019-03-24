//
//  GraphPointMarkerView.swift
//  How Are You?
//
//  Created by Zaccari Silverman on 3/19/19.
//  Copyright © 2019 RCOS-HowAreYou. All rights reserved.
//

import UIKit
import Charts

class GraphPointMarkerView: MarkerView {
    /*This is a feature under construction!
     This is how we'll tap on a point to show the point's notes to the user.
     */
    @IBOutlet weak var backgroundView: UIView!
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var rawScoreLabel: UILabel!
    @IBOutlet weak var notesLabel: UILabel!
    
    //This instantiates the class from a Nib. If we want an instance of this class, we want to use this.
    class func fromNib() -> GraphPointMarkerView {
        let view = Bundle.main.loadNibNamed(String(describing: GraphPointMarkerView.self), owner: nil, options: nil)![0] as! GraphPointMarkerView
        
        //Round the corners.
        view.layer.cornerRadius = 15
        view.clipsToBounds = true;
       
        //Draw the border.
        view.layer.borderColor = UIColor.gray.cgColor
        view.layer.borderWidth = 1
        
        //Add the shadow.
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 4, height: 4)
        
        
        //Eventually, we will want to add a method that prevents the view from ending up offscreen by calculating its x and y offsets more carefully.
        
        return view
    }
    

    //Refresh the content; i.e update it.
    override func refreshContent(entry: ChartDataEntry, highlight: Highlight) {
        guard let point = entry as? CustomGraphDataPoint else {
            //In this case, we have a problem. This shouldn't happen.
            fatalError("A ChartDataEntry could not be downcast to CustomGraphDataPoint...")
        }
        
        dateLabel.text = point.dateString
        rawScoreLabel.text = String(Int(point.y))
        notesLabel.text = point.notes
        
    }
    
  
}
