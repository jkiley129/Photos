//
//  AppDelegate.swift
//  Photos-Demo
//
//  Created by Joseph Kiley on 6/6/16.
//  Copyright © 2016 Joseph Kiley. All rights reserved.
//

import UIKit
import Alamofire

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        let initialViewController = storyboard.instantiateViewControllerWithIdentifier("VC")
        
        self.window?.rootViewController = initialViewController
        self.window?.makeKeyAndVisible()
        
        let urlString: String = "https://hingeq-homework.s3.amazonaws.com/client/services/homework.json"
        
        Alamofire.request(.GET, urlString) .responseJSON { response in
            print("The Request is: \(response.request)")  // original URL request
            print("The Response is: \(response.response)") // URL response
            print("The Data is: \(response.data)")     // server data
            print("The Result is: \(response.result)")   // result of response serialization
            
            if let JSON = response.result.value {
                print("JSON: \(JSON)")
            }
        }
        
        return true
    }
}

