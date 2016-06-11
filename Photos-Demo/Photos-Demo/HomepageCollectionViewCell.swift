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
    func loadImage(photo photo: ImageItem) {
        if let cachedImage: UIImage = ImageDataManager.sharedManager.retreiveCachedImage(urlString: photo.imageURL) {
            self.photoView.image = cachedImage
        } else {
            self.downloadPhoto(photo: photo)
        }
    }
    
    func downloadPhoto(photo photo: ImageItem) {
        if let urlString: String = photo.imageURL {
            ImageDataManager.sharedManager.getNetworkImage(urlString, completion: { image in
                self.photoView.image = image
            })
        }
    }
    
}
