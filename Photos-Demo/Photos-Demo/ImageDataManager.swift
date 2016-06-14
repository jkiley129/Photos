//
//  ImageDataManager.swift
//  Photos-Demo
//
//  Created by Joseph Kiley on 6/7/16.
//  Copyright © 2016 Joseph Kiley. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import Haneke

typealias ImageCompletionHandler = (success: Bool, results: [ImageItem]) -> Void
typealias ImageRetreivalCompletionHandler = (success: Bool, result: NSData) -> Void

class ImageDataManager: NSObject {
    
    // MARK: - Variables
    static let sharedManager = ImageDataManager()
    var images = [ImageItem]()
    
    let cache = Shared.dataCache
    
    func getImageResults(completionHandler completionHandler: ImageCompletionHandler) {
        
        let urlString: String = "https://hinge-homework.s3.amazonaws.com/client/services/homework.json"
        
        Alamofire.request(.GET, urlString) .responseJSON { response in
            
            if let JSON = response.result.value as? [[String: AnyObject]] {
                for item in JSON {
                    if let image: ImageItem = ImageItem(JSON: item) {
                        self.images.append(image)
                    }
                }
                completionHandler(success: true, results: self.images)
            }
        }
    }
    
    // MARK: - Image Caching
    func cacheImage(imageItem imageItem: ImageItem) {
        if let imageData: NSData = imageItem.imageData {
            self.cache.set(value: imageData, key: imageItem.description)
            print("\(imageItem.imageDescription) has been cached!")
        }
    }
    
    func retrieveCachedImage(urlString urlString: String, completionHandler: ImageRetreivalCompletionHandler) {
        self.cache.fetch(key: urlString).onSuccess { data in
            print("\(urlString) has been retrieved from the Cache!")
            completionHandler(success: true, result: data)
        }
    }
    
}