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
    var images = [ImageItem]()
    
    let decoder = ImageDecoder()
    let photoCache = AutoPurgingImageCache(memoryCapacity: 100 * 1024 * 1024, preferredMemoryUsageAfterPurge: 60 * 1024 * 1024)
    
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
    
    func getNetworkImage(urlString: String, completion: (UIImage? -> Void)) -> (ImageRequest) {
        let queue = decoder.queue.underlyingQueue
        let request = Alamofire.request(.GET, urlString)
        let imageRequest = ImageRequest(request: request)
        imageRequest.request.response(
            queue: queue,
            responseSerializer: Request.imageResponseSerializer(),
            completionHandler: { response in
                guard let image = response.result.value else {
                    return
                }
                let decodeOperation = self.decodeImage(image) { image in
                    completion(image)
                    self.cacheImage(image, urlString: urlString)
                }
                imageRequest.decodeOperation = decodeOperation
            }
        )
        return imageRequest
            
            
            
//        return Alamofire.request(.GET, urlString).responseImage { (response) -> Void in
//            guard let image = response.result.value else { return }
//            completion(image)
//            self.cacheImage(image: image, urlString: urlString)
//        }
    }
    
    func decodeImage(image image: UIImage, completion: (UIImage -> Void)) -> DecodeOperation {
        let decodeOperation = DecodeOperation(image: image, decoder: self.decoder, completion: completion)
        self.decoder.queue.addOperation(decodeOperation)
        return decodeOperation
    }
    
    // MARK: - Image Caching
    func cacheImage(image image: UIImage, urlString: String) {
        self.photoCache.addImage(image, withIdentifier: urlString)
    }
    
    func retreiveCachedImage(urlString urlString: String) -> UIImage? {
        return photoCache.imageWithIdentifier(urlString)
    }
    
}