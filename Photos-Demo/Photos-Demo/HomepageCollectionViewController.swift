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
    private let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.greenColor()
    }
    
    // MARK: - CollectionView DataSource
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell: HomepageCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier(self.photoReuseID, forIndexPath: indexPath) as! HomepageCollectionViewCell
        
        cell.backgroundColor = UIColor.redColor()
        
        cell.photoView.image = UIImage(named: "Overwatch")
        
        return cell
    }
    
}

// MARK: - CollectionView Delegate Flow Layout
extension HomepageCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: OrientationManager.deviceWidth() / 2, height: OrientationManager.deviceHeight() / 3.25)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0.0
    }
    
}