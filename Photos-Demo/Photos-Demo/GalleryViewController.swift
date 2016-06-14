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

    var currentImageItem: ImageItem?
    var galleryCount: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "\(self.galleryCount + 1) / \(ImageDataManager.sharedManager.images.count)"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Trash, target: self, action: #selector(GalleryViewController.deletePhoto))
        
        if let currentImage: ImageItem = self.currentImageItem {
            self.downloadImage(imageItem: currentImage)
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (__int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), {
            self.animateImageTransition()
        });
        
    }
    
    // MARK: - Image Handling
    // Note: Haneke automatically caches the image, by calling this again once the image has been downloaded, I am just directing it which image to use
    func downloadImage(imageItem imageItem: ImageItem) {
        if let urlString: String = imageItem.imageURL {
            if let URL: NSURL = NSURL(string: urlString) {
                self.largePhotoView.hnk_setImageFromURL(URL)
            }
        }
    }
    
    // MARK: - Actions
    func deletePhoto() {
        ImageDataManager.sharedManager.images.removeAtIndex(self.galleryCount)
        self.view.reloadInputViews()
    }
    
    func switchToNextImage() {
        self.galleryCount += 1
        if self.galleryCount > ImageDataManager.sharedManager.images.count - 1 {
            self.galleryCount = 0
        }
        
        let currentImage = ImageDataManager.sharedManager.images[self.galleryCount]
        self.downloadImage(imageItem: currentImage)
        
        navigationItem.title = "\(self.galleryCount + 1) / \(ImageDataManager.sharedManager.images.count)"
    }
    
    func animateImageTransition() {
        CATransaction.begin()
        
        let animationDuration: NSTimeInterval = 0.5
        let switchTimeInterval: NSTimeInterval = 2.0
        CATransaction.setAnimationDuration(animationDuration)
        CATransaction.setCompletionBlock { 
            let delay = dispatch_time(DISPATCH_TIME_NOW, Int64(switchTimeInterval * NSTimeInterval(NSEC_PER_SEC)))
            dispatch_after(delay, dispatch_get_main_queue(), { 
                self.animateImageTransition()
            })
        }
        
        let transition = CATransition()
        transition.type = kCATransitionFade
        self.largePhotoView.layer.addAnimation(transition, forKey: kCATransition)
        self.switchToNextImage()
        
        CATransaction.commit()
    }

}
