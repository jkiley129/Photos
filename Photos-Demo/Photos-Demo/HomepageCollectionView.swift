//
//  HomepageCollectionView.swift
//  Photos-Demo
//
//  Created by Joseph Kiley on 6/7/16.
//  Copyright © 2016 Joseph Kiley. All rights reserved.
//

import UIKit

class HomepageCollectionView: UIView {
    
    // MARK: - Variables
    let reuseID: String = "reuseId.photo"
    let numbers = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
    
    // MARK: - View Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(self.photosCollectionView)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Layout
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.photosCollectionView.frame = self.bounds
    }
    
    // MARK: - Lazy Initialization
    lazy var photosCollectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = UICollectionViewScrollDirection.Vertical
        let collectionView: UICollectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.clearColor()
        collectionView.showsVerticalScrollIndicator = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.alwaysBounceHorizontal = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.registerClass(HomepageCollectionViewCell.self, forCellWithReuseIdentifier: self.reuseID)
        return collectionView
    }()

}

extension HomepageCollectionView: UICollectionViewDataSource {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
         let cell: HomepageCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier(self.reuseID, forIndexPath: indexPath) as! HomepageCollectionViewCell
        
        cell.numberLabel.text = numbers[indexPath.item]
        
        return cell
    }

}

extension HomepageCollectionView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let fullHeight: Double = Double(self.bounds.height)
        let fullWidth: Double = Double(self.bounds.width)
        
        return CGSize(width: fullWidth / 2.0, height: fullHeight / 3.5)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0.0
    }
}


