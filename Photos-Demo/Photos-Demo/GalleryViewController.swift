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
        
        if let image: ImageItem = self.currentImage {
            if let imageData: NSData = image.imageData {
                self.largePhotoView.image = UIImage(data: imageData)
            } else {
                self.configureWithImageItem(imageItem: image)
            }
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Trash, target: self, action: Selector("deletePhoto:"))
        
        self.scheduleGalleryTimerWithInterval()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Actions
    func configureWithImageItem(imageItem imageItem: ImageItem) {
        if let imageData: NSData = imageItem.imageData {
            self.largePhotoView.image = UIImage(data: imageData)
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
                                    self.largePhotoView.image = image
                                })
                            }
                        }
                    }
                })
            }
        }
    }
    
    func deletePhoto() {
        
    }
    
    func scheduleGalleryTimerWithInterval() {
        self.galleryTimer = NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: #selector(GalleryViewController.switchToNexPhoto), userInfo: nil, repeats: true)
    }
    
    func switchToNexPhoto() {
        
        self.galleryCount += 1
        if self.galleryCount > self.totalImages.count {
            self.galleryCount = 0
        }
        self.currentImage = self.totalImages[self.galleryCount]
        if let newImage: ImageItem = self.currentImage {
            self.configureWithImageItem(imageItem: newImage)
        }
    }

}
