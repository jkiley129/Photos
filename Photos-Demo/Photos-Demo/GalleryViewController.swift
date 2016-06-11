//
//  GalleryViewController.swift
//  Photos-Demo
//
//  Created by Joseph Kiley on 6/8/16.
//  Copyright © 2016 Joseph Kiley. All rights reserved.
//

import UIKit
import Foundation

class GalleryViewController: UIViewController {

    // MARK: - Variables
    @IBOutlet weak var largePhotoView: UIImageView!
    
    var currentImage: ImageItem?
    var totalImages: [ImageItem] = [ImageItem]()
    var galleryTimer: NSTimer = NSTimer()
    var galleryCount: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let currentImage: ImageItem = self.currentImage {
            self.loadImage(image: currentImage)
        }
        
        navigationItem.title = "\(self.galleryCount + 1) / \(self.totalImages.count)"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Trash, target: self, action: #selector(GalleryViewController.deletePhoto))
        
        self.scheduleGalleryTimerWithInterval()
        
    }
    
    // MARK: - Actions
    func loadImage(image image: ImageItem) {
        if let cachedImage: UIImage = ImageDataManager.sharedManager.retreiveCachedImage(urlString: image.imageURL) {
            self.largePhotoView.image = cachedImage
        } else {
            self.downloadImage(image: image)
        }
    }
    
    func downloadImage(image image: ImageItem) {
        if let urlString: String = image.imageURL {
            ImageDataManager.sharedManager.getNetworkImage(urlString, completion: { image in
                self.largePhotoView.image = image
            })
        }
    }
    
    func deletePhoto() {
        ImageDataManager.sharedManager.images.removeAtIndex(self.galleryCount)
    }
    
    func scheduleGalleryTimerWithInterval() {
        self.galleryTimer = NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: #selector(GalleryViewController.switchToNextImage), userInfo: nil, repeats: true)
    }
    
    func switchToNextImage() {
        
        self.galleryCount += 1
        if self.galleryCount > self.totalImages.count - 1 {
            self.galleryCount = 0
        }
        self.currentImage = self.totalImages[self.galleryCount]
        if let newImage: ImageItem = self.currentImage {
            self.loadImage(image: newImage)
        }
        navigationItem.title = "\(self.galleryCount + 1) / \(self.totalImages.count)"
    }

}
