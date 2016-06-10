//
//  GalleryViewController.swift
//  Photos-Demo
//
//  Created by Joseph Kiley on 6/8/16.
//  Copyright © 2016 Joseph Kiley. All rights reserved.
//

import UIKit

class GalleryViewController: UIViewController {

    // MARK: - Variables
    @IBOutlet weak var largePhotoView: UIImageView!
    var image: ImageItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let image: ImageItem = self.image {
            if let imageData: NSData = image.imageData {
                self.largePhotoView.image = UIImage(data: imageData)
            } else {
                self.configureCellWithImageItem(imageItem: image)
            }
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Trash, target: self, action: Selector("deletePhoto:"))
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Actions
    func configureCellWithImageItem(imageItem imageItem: ImageItem) {
        if let imageURL: String = imageItem.imageURL {
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
