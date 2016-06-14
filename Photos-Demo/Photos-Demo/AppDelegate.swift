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
    var networkStatus: ReachabilityStatus!

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        var reachability: Reachability!
        
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        let initialViewController = storyboard.instantiateViewControllerWithIdentifier("VC")
        
        self.window?.rootViewController = initialViewController
        self.window?.makeKeyAndVisible()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector:#selector(AppDelegate.checkForReachability(_:)), name: kReachabilityChangedNotification, object: nil)
        reachability = Reachability.reachabilityForInternetConnection()
        reachability.startNotifier()
        
        return true
    }
    
    func checkForReachability(notification: NSNotification) {
        if let networkReachability = notification.object as? Reachability {
            let remoteHostStatus = networkReachability.currentReachabilityStatus()
            
            if (remoteHostStatus == NotReachable) {
                print("Shit just isn't reachable")
            } else if (remoteHostStatus == ReachableViaWiFi) {
                print("Shit is only reachable via WIFI")
            } else {
                print("Shit is just plain reachable!")
            }
        } else {
            print("I ain't got no god damn clue what's going on")
        }
    }
    
}



