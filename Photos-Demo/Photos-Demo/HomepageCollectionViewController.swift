//
//  HomepageCollectionViewController.swift
//  Photos-Demo
//
//  Created by Joseph Kiley on 6/7/16.
//  Copyright © 2016 Joseph Kiley. All rights reserved.
//

import UIKit

class HomepageCollectionViewController: UICollectionViewController {
    
    // MARK: - Variables
    private let photoReuseID: String = "photoCell"
    private let segueIdentifier: String = "gallerySegue"
    let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if AppDelegate.checkNetworkStatus() == true {
            ImageDataManager.sharedManager.getImageResults { (success, results) in
                self.reloadCollectionView()
            }
        } else {
            self.collectionView?.hidden = true
            self.addNoDataConnectionLabel()
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.view.backgroundColor = UIColor.whiteColor()
        self.reloadCollectionView()
    }
    
    // MARK: - Actions
    func reloadCollectionView() {
        self.collectionViewLayout.invalidateLayout()
        self.collectionView?.reloadData()
    }
    
    func addNoDataConnectionLabel() {
        let noDataConnectionLabel: UILabel = UILabel()
        noDataConnectionLabel.text = "Looks like you're not connected to the internet. Please connect to view photo content"
        noDataConnectionLabel.numberOfLines = 0
        noDataConnectionLabel.lineBreakMode = .ByWordWrapping
        let labelWidth: Double = OrientationManager.deviceWidth() - 16.0
        let labelHeight: Double = OrientationManager.deviceHeight() / 2.0
        let x: Double = 8.0; let y: Double = (OrientationManager.deviceHeight() - labelHeight) / 2.0; let w: Double = labelWidth; let h: Double = labelHeight
        noDataConnectionLabel.frame = CGRect(x: x, y: y, width: w, height: h)
        self.view.addSubview(noDataConnectionLabel)
    }
    
    // MARK: - CollectionView DataSource
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ImageDataManager.sharedManager.images.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell: HomepageCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier(self.photoReuseID, forIndexPath: indexPath) as! HomepageCollectionViewCell
        
        if ImageDataManager.sharedManager.images.count > indexPath.item {
            let selectedImageItem: ImageItem = ImageDataManager.sharedManager.images[indexPath.item]
            cell.downloadImage(imageItem: selectedImageItem)
        }
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "gallerySegue" {
            let indexPath = self.collectionView?.indexPathForCell(sender as! UICollectionViewCell)
            let destinationVC = segue.destinationViewController as! GalleryViewController
            if let item: Int = indexPath?.item {
                let currentImage: ImageItem = ImageDataManager.sharedManager.images[item]
                destinationVC.currentImageItem = currentImage
                destinationVC.galleryCount = item
            }
        }
    }
    
}

// MARK: - CollectionView Delegate Flow Layout
extension HomepageCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let width: Double = OrientationManager.deviceWidth() / 2

        return CGSize(width: width, height: width)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0.0
    }
    
}