//
//  DisclaimerViewController.swift
//  How Are You?
//
//  Created by Zaccari Silverman on 1/26/19.
//  Copyright © 2019 RCOS-HowAreYou. All rights reserved.
//

import UIKit

class DisclaimerViewController : UIViewController {
    
    @IBOutlet weak var disclaimerTextBodyLabel: UILabel!
    
    @IBOutlet weak var continueButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }
    
    @IBAction func continueButtonPressed(_ sender: Any) {
        /*Transition to the next VC.*/
        //Currently, this will just move us to the main storyboard.
        //Ideally, if there was any code we wanted to run before this, we'd want to run it now.
        
        let initVC = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as! HAYTabBarController
        self.present(initVC, animated: true) {
            //Completion closure.
        }
        
        
    }
    
    
    
}
