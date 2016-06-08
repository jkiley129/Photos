//
//  AppDelegate.swift
//  Photos-Demo
//
//  Created by Joseph Kiley on 6/6/16.
//  Copyright © 2016 Joseph Kiley. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        var rootViewController: HomepageViewController = HomepageViewController()
        
        let navController: UINavigationController = UINavigationController(rootViewController: rootViewController)
        
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        if let window = window {
            window.rootViewController = rootViewController
            window.makeKeyAndVisible()
        }
        return true
    }
}

