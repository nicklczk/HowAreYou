//
//  Constants.swift
//  How Are You?
//
//  Created by Zaccari Silverman on 1/26/19.
//  Copyright © 2019 RCOS-HowAreYou. All rights reserved.
//

import Foundation
import UIKit

/*
 This file is empty.
 
 In the future, if there are any constant values that we may want to change in the future (say, a thematic color), we might want to put them here.
 That way, if we ever want to update a value referenced here, we only need to update it once (here) rather than having to hunt all occurences of said value down.
 */

final class Constants {
    // classes can't be static, but values can be.
    
    /*MOC == Managed Object Context.
     *This is a reference we will need to use Core Data.
     *This line of code is a bit ugly, so let's just 
     */
    static let moc = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    static var userLineColor : UIColor {
        let hue = CGFloat(UserDefaults.standard.float(forKey: "savedColorHue")) //Should return 0 if it doesn't exist.
        return UIColor(hue: hue, saturation: 1.0, brightness: 1.0, alpha: 1.0)
    }
    
}
