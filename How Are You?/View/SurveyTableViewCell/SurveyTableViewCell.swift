//
//  SurveyTableViewCell.swift
//  How Are You?
//
//  Created by Zaccari Silverman on 1/29/19.
//  Copyright © 2019 RCOS-HowAreYou. All rights reserved.
//

import UIKit

class SurveyTableViewCell: UITableViewCell {

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Note to self: disable selection later on
        // Configure the view for the selected state
    }
    
}
