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

typealias ImageCompletionHandler = (success: Bool, results: [ImageItem]) -> Void

class ImageDataManager: NSObject {
    
    // MARK: - Variables
    static let sharedManager = ImageDataManager()
    let photoCache = AutoPurgingImageCache(memoryCapacity: 100 * 1024 * 1024, preferredMemoryUsageAfterPurge: 60 * 1024 * 1024)
    
    func getImageResults(completionHandler completionHandler: ImageCompletionHandler) {
        
        let urlString: String = "https://hinge-homework.s3.amazonaws.com/client/services/homework.json"
        var images: [ImageItem] = [ImageItem]()
        
        Alamofire.request(.GET, urlString) .responseJSON { response in
            
            if let JSON = response.result.value as? [[String: AnyObject]] {
                for item in JSON {
                    if let image: ImageItem = ImageItem(JSON: item) {
                        images.append(image)
                    }
                }
                completionHandler(success: true, results: images)
            }
        }
    }
    
    func getNetworkImage(urlString: String, completion: (UIImage? -> Void)) -> (Request) {
        return Alamofire.request(.GET, urlString).responseImage { (response) -> Void in
            guard let image = response.result.value else { return }
            completion(image)
            
        }
    }
    
    func cacheImage(image image: UIImage, urlString: String) {
        self.photoCache.addImage(image, withIdentifier: urlString)
    }
    
    func retreiveCachedImage(urlString urlString: String) -> UIImage? {
        return photoCache.imageWithIdentifier(urlString)
    }
    
}