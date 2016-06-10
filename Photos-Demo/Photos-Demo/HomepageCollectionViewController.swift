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

    var images: [ImageItem] = [ImageItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.greenColor()
        
        ImageDataManager.getImageResults { (success: Bool, results: [ImageItem]) in
            self.images = results
            self.reloadCollectionView()
            print(self.images.count)
        }
    }
    
    // MARK: - Actions
    func reloadCollectionView() {
        self.collectionViewLayout.invalidateLayout()
        self.collectionView?.reloadData()
    }
    
    // MARK: - CollectionView DataSource
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.images.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell: HomepageCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier(self.photoReuseID, forIndexPath: indexPath) as! HomepageCollectionViewCell
        
        if self.images.count > indexPath.item {
            cell.configureCellWithImageItem(imageItem: images[indexPath.item])
        }
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "gallerySegue" {
            let indexPath = self.collectionView?.indexPathForCell(sender as! UICollectionViewCell)
            let destinationVC = segue.destinationViewController as! GalleryViewController
            if let item = indexPath?.item {
                let image: ImageItem = self.images[item]
                destinationVC.image = image
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