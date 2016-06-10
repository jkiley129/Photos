//
//  HomepageCollectionViewCell.swift
//  Photos-Demo
//
//  Created by Joseph Kiley on 6/7/16.
//  Copyright © 2016 Joseph Kiley. All rights reserved.
//

import UIKit

class HomepageCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Variables
    @IBOutlet weak var photoView: UIImageView!
    
    // MARK: - Actions
    func configureCellWithImageItem(imageItem imageItem: ImageItem) {
        if let imageData: NSData = imageItem.imageData {
            self.photoView.image = UIImage(data: imageData)
        } else if let imageURL: String = imageItem.imageURL {
            if let url: NSURL = NSURL(string: imageURL) {
                let request: NSURLRequest = NSURLRequest(URL: url)
                let mainQueue: NSOperationQueue = NSOperationQueue.mainQueue()
                NSURLConnection.sendAsynchronousRequest(request, queue: mainQueue, completionHandler: { (response, data, error) in
                    if error == nil {
                        if let data = data {
                            if let image: UIImage = UIImage(data: data) {
                                imageItem.image = image
                                imageItem.imageData = data
                                dispatch_async(dispatch_get_main_queue(), {
                                    self.photoView.image = image
                                })
                            }
                        }
                    }
                })
            }
        }
    }
    
    
}
