//
//  AboutHAYViewController.swift
//  How Are You?
//
//  Created by Zaccari Silverman on 4/14/19.
//  Copyright © 2019 RCOS-HowAreYou. All rights reserved.
//

import UIKit

class AboutHAYViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func icons8ButtonPressed(_ sender: Any) {
        //One condition that Icons8 imposes as part of its free license is that you must link to their website somewhere in the app. This is the main reason I'm adding this about screen at all.
        guard let url = URL(string: "https://icons8.com/") else {
            self.presentDialogBox(withTitle: "Error", withMessage: "Opening Safari to link to icons8.com failed.")
            return
        }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    

}
