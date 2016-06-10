//
//  ImageDataManager.swift
//  Photos-Demo
//
//  Created by Joseph Kiley on 6/7/16.
//  Copyright © 2016 Joseph Kiley. All rights reserved.
//

import UIKit
import Alamofire

class ImageDataManager: NSObject {
    
    class func getImageResults() -> [ImageItem] {
        
        let urlString: String = "https://hinge-homework.s3.amazonaws.com/client/services/homework.json"
        var images: [ImageItem] = [ImageItem]()
        
        Alamofire.request(.GET, urlString) .responseJSON { response in
            
            if let JSON = response.result.value as? [[String: AnyObject]] {
//                print("JSON: \(JSON)")
                for item in JSON {
                    if let image: ImageItem = ImageItem(JSON: item) {
                        images.append(image)
                    }
                }
            }
        }
        print(images)
        return images
    }
}