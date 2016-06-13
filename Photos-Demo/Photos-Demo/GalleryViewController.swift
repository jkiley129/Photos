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
    var request: ImageRequest?
    var galleryTimer: NSTimer = NSTimer()
    var galleryCount: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loadImage()
        
        navigationItem.title = "\(self.galleryCount + 1) / \(ImageDataManager.sharedManager.images.count)"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Trash, target: self, action: #selector(GalleryViewController.deletePhoto))
        
        self.scheduleGalleryTimerWithInterval()
        
    }
    
    // MARK: - Cell Configuration
    func configureGalleryView(imageItem imageItem: ImageItem) {
        self.currentImage = imageItem
        self.reset()
        self.loadImage()
    }
    
    func reset() {
        self.largePhotoView.image = nil
        request?.cancel()
    }
    
    // MARK: - Image Handling
    func loadImage() {
        if let image: ImageItem = self.currentImage {
            if let cachedImage = ImageDataManager.sharedManager.retreiveCachedImage(urlString: image.imageURL) {
                self.largePhotoView.image = cachedImage
            } else {
                self.downloadImage()
            }
        }
    }
    
    func downloadImage() {
        if let urlString: String = self.currentImage?.imageURL {
            request = ImageDataManager.sharedManager.getNetworkImage(urlString, completion: { image in
                if let image: UIImage = image {
                    self.largePhotoView.image = image
                    if let imageItem: ImageItem = self.currentImage {
                        ImageDataManager.sharedManager.cacheImage(image: image, urlString: imageItem.imageURL)
                    }
                }
            })
        }
    }
    
    // MARK: - Actions
    func deletePhoto() {
        ImageDataManager.sharedManager.images.removeAtIndex(self.galleryCount)
    }
    
    func scheduleGalleryTimerWithInterval() {
        self.galleryTimer = NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: #selector(GalleryViewController.switchToNextImage), userInfo: nil, repeats: true)
    }
    
    func switchToNextImage() {
        
        self.galleryCount += 1
        if self.galleryCount > ImageDataManager.sharedManager.images.count - 1 {
            self.galleryCount = 0
        }
        self.currentImage = ImageDataManager.sharedManager.images[self.galleryCount]
        self.loadImage()
        navigationItem.title = "\(self.galleryCount + 1) / \(ImageDataManager.sharedManager.images.count)"
    }

}
