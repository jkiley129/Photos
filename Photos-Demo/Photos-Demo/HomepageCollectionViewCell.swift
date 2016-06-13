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
    var request: ImageRequest?
    
    // MARK: - Reuse
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.photoView.image = nil
    }
    
    // MARK: - Cell Configuration
    func configureHomepageCell(imageItem imageItem: ImageItem) {
        self.imageItem = imageItem
        self.reset()
        self.loadImage()
    }
    
    func reset() {
        self.photoView.image = nil
        request?.cancel()
    }
    
    // MARK: - Image Handling
    func loadImage() {
        if let image: ImageItem = self.imageItem {
            if let urlString: String = image.imageURL {
                if let URL: NSURL = NSURL(string: urlString) {
                    self.photoView.hnk_setImageFromURL(URL)
                    self.layoutSubviews()
                }
            }
        }
//        if let image: ImageItem = self.imageItem {
//            if let cachedImage = ImageDataManager.sharedManager.retreiveCachedImage(urlString: image.imageURL) {
//                self.photoView.image = cachedImage
//            } else {
//                self.downloadImage()
//            }
//        }
    }
    
    func downloadImage() {
        if let urlString: String = self.imageItem?.imageURL {
            if let URL: NSURL = NSURL(string: urlString) {
                self.photoView.hnk_setImageFromURL(URL)
            }
//            request = ImageDataManager.sharedManager.getNetworkImage(urlString, completion: { image in
//                if let image: UIImage = image {
//                    self.photoView.image = image
//                    if let imageItem: ImageItem = self.imageItem {
//                        ImageDataManager.sharedManager.cacheImage(image: image, urlString: imageItem.imageURL)
//                    }
//                }
//            })
        }
    }
    
}
