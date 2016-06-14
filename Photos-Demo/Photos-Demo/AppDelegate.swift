//
//  AppDelegate.swift
//  Photos-Demo
//
//  Created by Joseph Kiley on 6/6/16.
//  Copyright © 2016 Joseph Kiley. All rights reserved.
//

import UIKit
import Alamofire

enum ReachabilityStatus {
    case NotReachable
    case WifiReachable
    case WWANReachable
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        let initialViewController = storyboard.instantiateViewControllerWithIdentifier("VC")
        
        self.window?.rootViewController = initialViewController
        self.window?.makeKeyAndVisible()
        
        return true
        
    }
    
    class func checkNetworkStatus() -> Bool {
        let reachability: Reachability = Reachability.reachabilityForInternetConnection()
        let networkStatus = reachability.currentReachabilityStatus().rawValue;
        var isAvailable  = false;
        
        switch networkStatus {
        case (NotReachable.rawValue):
            isAvailable = false;
            break;
        case (ReachableViaWiFi.rawValue):
            isAvailable = true;
            break;
        case (ReachableViaWWAN.rawValue):
            isAvailable = true;
            break;
        default:
            isAvailable = false;
            break;
        }
        return isAvailable;
    }
    
}



