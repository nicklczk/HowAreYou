//
//  HAYTabBarController.swift
//  How Are You?
//
//  Created by Zaccari Silverman on 1/26/19.
//  Copyright © 2019 RCOS-HowAreYou. All rights reserved.
//

import UIKit

class HAYTabBarController: UITabBarController {

    static var instance : HAYTabBarController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        HAYTabBarController.instance = self //This should only happen once.
        
        // Do any additional setup after loading the view.
    }

    
    /*In case we want to do anything special with our tab bar controller.*/

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
