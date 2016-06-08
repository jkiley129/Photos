//
//  OrientationManager.swift
//  Vine Coding Challenge
//
//  Created by Joseph Kiley on 5/19/16.
//  Copyright © 2016 Joseph Kiley. All rights reserved.
//

import UIKit

class OrientationManager: NSObject {
    
    class func deviceHeight() -> Double {
        return Double(CGRectGetHeight(UIScreen.mainScreen().bounds))
    }
    
    class func deviceWidth() -> Double {
        return Double(CGRectGetWidth(UIScreen.mainScreen().bounds))
    }

}
