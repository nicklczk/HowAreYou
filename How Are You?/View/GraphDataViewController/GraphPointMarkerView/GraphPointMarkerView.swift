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
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
       
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
        
        //Change the height of the notes label to be as small as possible given the content.
        //No other label will be multiple lines, so they don't need this line here.
        notesLabel.heightToContent()
        
        //This adjusts the widths of each label to be the minimum possible.
        dateLabel.widthToContent()
        rawScoreLabel.widthToContent() //Unlikely that this matters, but I'll put it here for completeness's sake.
        notesLabel.widthToContent()
        
        //If the notes label is super-wide for some reason still, set its width to a static 260.
        if (notesLabel.frame.width > 200){
            notesLabel.frame.size.width = 200
            notesLabel.lineBreakMode = .byWordWrapping
        }
        
        //If the notes label is super-tall for some reason still, try resizing it again.
        if (notesLabel.frame.height > notesLabel.frame.width){
            notesLabel.heightToContent()
        }
        
        //Now that the subviews have had their sizes made as small as possible, we can make the marker's overall size as small as possible.

        //Now, update this view's height.
        //Top margin size of 12 + height of date label + margin of 8 + score label height + margin of 8 + notes label height + margin of 12
        frame.size.height = dateLabel.frame.height + rawScoreLabel.frame.height + notesLabel.frame.height + 40.0
        
        //Now, update this view's width.
        //Make it the maximum width of any given subview, plus 24 for the side margins.
        frame.size.width = max(dateLabel.frame.width, max(notesLabel.frame.width, rawScoreLabel.frame.width)) + 24.0
        
    }
    
    override func offsetForDrawing(atPoint point: CGPoint) -> CGPoint {
        var newOffset = CGPoint(x: 0, y: 0)
        
        //15 is the axis margin, from what I can tell.
        if (point.x + self.frame.maxX > UIScreen.main.bounds.maxX - 15.0){
            newOffset.x = -(point.x + self.frame.maxX - (UIScreen.main.bounds.maxX - 15.0))
        }
        
        let tabBarHeight = (HAYTabBarController.instance!.tabBar.frame.height)
        
        if (point.y + self.frame.maxY > UIScreen.main.bounds.maxY - (tabBarHeight + 60)){
            newOffset.y = -(point.y + self.frame.maxY - (UIScreen.main.bounds.maxY - (tabBarHeight + 60)))
        }
        //If we made changes, let's return our modified offset.
        if (newOffset.x != 0 || newOffset.y != 0) {
            return newOffset
        }
        //If we made no changes, we want to return self.offset, as recommended by the documentation for the Charts API
        return (self.offset)
        
    }
    
  
}
