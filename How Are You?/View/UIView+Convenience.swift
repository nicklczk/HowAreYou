//
//  UIView+ConvenienceGraphics.swift
//  How Are You?
//
//  Created by Zaccari Silverman on 1/26/19.
//  Copyright © 2019 RCOS-HowAreYou. All rights reserved.
//

import UIKit

extension UIView {
    
    
    /**
        Takes the view and rounds its corners based on its height.
     */
    func pill(){
        self.layer.cornerRadius = self.frame.height/2
        self.clipsToBounds = true;
    }
    
    /**
        Calling this will allow a UIView or any subclass of it to instantiate itself from a nib easily.
     */
    class func fromNib<T: UIView>() -> T {
        return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
    
}
