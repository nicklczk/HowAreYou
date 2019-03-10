//
//  SurveyTableViewCell.swift
//  How Are You?
//
//  Created by Zaccari Silverman on 1/29/19.
//  Copyright © 2019 RCOS-HowAreYou. All rights reserved.
//

import UIKit

class SurveyTableViewCell: UITableViewCell {

    static let reuseIdentifier = "SurveyTableViewCell"
    
    //This reference is stored so that when the segmented control is updated, the cell can tell the SurveyViewController to update its corresponding data.
    //This is basically delegation (though I haven't defined a protocol).
    weak var surveyViewController : SurveyViewController!
    
    var cellIndex : Int!
    
    @IBOutlet weak var questionNumberLabel: UILabel!
    
    @IBOutlet weak var questionContentLabel: UILabel!
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //Some devices are too narrow to display all of the segmented control text correctly.
        //Rather than change it for every device, we can define it for those special-case devices here.
        //TODO: Actually implement the code that determines if a device needs the narrowed button titles.
        
        //If questionStrings is non-nil,
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // These cells shouldn't be selectable, so this shouldn't matter.
    }
    
    @IBAction func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        surveyViewController.surveyCellDidSelectNewSegment(cellIndex: cellIndex, value: segmentedControl.selectedSegmentIndex)
        
    }
    
    
}
