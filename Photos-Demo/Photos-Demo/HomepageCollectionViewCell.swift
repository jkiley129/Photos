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
    func downloadImage(imageItem imageItem: ImageItem) {
        if let urlString: String = imageItem.imageURL {
            if let URL: NSURL = NSURL(string: urlString) {
                self.photoView.hnk_setImageFromURL(URL)
                ImageDataManager.sharedManager.cacheImage(imageItem: imageItem)
            }
        }
    }
    
}
