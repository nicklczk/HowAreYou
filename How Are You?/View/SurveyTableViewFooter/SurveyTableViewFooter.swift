//
//  SurveyTableViewFooter.swift
//  How Are You?
//
//  Created by Zaccari Silverman on 2/7/19.
//  Copyright © 2019 RCOS-HowAreYou. All rights reserved.
//

import UIKit

class SurveyTableViewFooter: UIView {

    static let reuseIdentifier = "SurveyTableViewFooter"
    
    weak var surveyViewController : SurveyViewController!
    
    @IBOutlet weak var submitButton: UIButton!
    
    @IBAction func submitButtonPressed(_ sender: Any) {
        surveyViewController.footerDidPressSubmitButton()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //Initialization code. We can make the views fancy here.
        submitButton.backgroundColor = self.tintColor
        submitButton.tintColor = .white
        
        submitButton.pill()
    }
    
}
