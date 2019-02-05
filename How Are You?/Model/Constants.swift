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
    
    // This is just the sort of thing that would make sense here.
    
    static let exampleVariable : UIColor = .black
    
    static var exampleCalculatedVariable : String {
        //Returns the current date and time as a string.
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .long
        return dateFormatter.string(from: Date())
    }
    
    
    
}
