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
    var galleryTimer: NSTimer = NSTimer()
    var galleryCount: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let currentImage: ImageItem = self.currentImage {
            self.downloadImage(imageItem: currentImage)
        }
        
        navigationItem.title = "\(self.galleryCount + 1) / \(ImageDataManager.sharedManager.images.count)"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Trash, target: self, action: #selector(GalleryViewController.deletePhoto))
        
        self.scheduleGalleryTimerWithInterval()
        
    }
    
    // MARK: - Image Handling
    func downloadImage(imageItem imageItem: ImageItem) {
        self.largePhotoView.image = nil
        if let urlString: String = imageItem.imageURL {
            if let URL: NSURL = NSURL(string: urlString) {
                self.largePhotoView.hnk_setImageFromURL(URL)
            }
        }
    }
    
    // MARK: - Actions
    func deletePhoto() {
        ImageDataManager.sharedManager.images.removeAtIndex(self.galleryCount)
    }
    
    func scheduleGalleryTimerWithInterval() {
        self.galleryTimer = NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: #selector(GalleryViewController.switchToNextImage), userInfo: nil, repeats: true)
        self.animateImageTransition()
    }
    
    func switchToNextImage() {
        self.galleryCount += 1
        if self.galleryCount > ImageDataManager.sharedManager.images.count - 1 {
            self.galleryCount = 0
        }
        self.currentImage = ImageDataManager.sharedManager.images[self.galleryCount]
        if let currentImage: ImageItem = self.currentImage {
            self.downloadImage(imageItem: currentImage)
        }
        navigationItem.title = "\(self.galleryCount + 1) / \(ImageDataManager.sharedManager.images.count)"
    }
    
    func animateImageTransition() {
        CATransaction.begin()
        
        let animationDuration: NSTimeInterval = 0.25
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
