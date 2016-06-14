//
//  HomepageCollectionViewCell.swift
//  Photos-Demo
//
//  Created by Joseph Kiley on 6/7/16.
//  Copyright © 2016 Joseph Kiley. All rights reserved.
//

import UIKit
import ImageIO
import Alamofire
import AlamofireImage
import Haneke

class HomepageCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Variables
    @IBOutlet weak var photoView: UIImageView!
    var imageItem: ImageItem?
    
    // MARK: - Reuse
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.photoView.image = nil
    }
    
    // MARK: - Image Handling
    func loadImage(imageItem imageItem: ImageItem) {
        if let urlString: String = imageItem.imageURL {
            ImageDataManager.sharedManager.retrieveCachedImage(urlString: urlString, completionHandler: { (success: Bool, result: NSData) in
                if success != false {
                    self.photoView.image = UIImage(data: result)
                } else {
                    self.downloadImage(imageItem: imageItem)
                }
            })
        }
    }
    
    func downloadImage(imageItem imageItem: ImageItem) {
        if let urlString: String = imageItem.imageURL {
            if let URL: NSURL = NSURL(string: urlString) {
                self.photoView.hnk_setImageFromURL(URL)
                ImageDataManager.sharedManager.cacheImage(imageItem: imageItem)
            }
        }
    }
    
}
