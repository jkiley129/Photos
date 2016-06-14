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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.greenColor()
        
        ImageDataManager.sharedManager.getImageResults { (success, results) in
            self.reloadCollectionView()
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.reloadCollectionView()
    }
    
    // MARK: - Actions
    func reloadCollectionView() {
        self.collectionViewLayout.invalidateLayout()
        self.collectionView?.reloadData()
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