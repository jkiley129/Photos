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
    
    let photos: [String] = ["Genji", "Overwatch", "Hanzo", "Junkrat", "Mercy", "Pharah", "Reaper", "Reinhardt", "Tracer", "Zenyatta"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.greenColor()
        
        ImageDataManager.getImageResults()
    }
    
    // MARK: - CollectionView DataSource
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell: HomepageCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier(self.photoReuseID, forIndexPath: indexPath) as! HomepageCollectionViewCell
        
        cell.backgroundColor = UIColor.redColor()
        
        cell.photoView.image = UIImage(named: photos[indexPath.item])
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "gallerySegue" {
            let indexPath = self.collectionView?.indexPathForCell(sender as! UICollectionViewCell)
            let destinationVC = segue.destinationViewController as! GalleryViewController
            if let item = indexPath?.item {
                let imageNameForIndexPath = photos[item]
                destinationVC.imageName = imageNameForIndexPath
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