//
//  HomepageCollectionViewCell.swift
//  Photos-Demo
//
//  Created by Joseph Kiley on 6/7/16.
//  Copyright © 2016 Joseph Kiley. All rights reserved.
//

import UIKit

class HomepageCollectionViewCell: UICollectionViewCell {
    
    // MARK: - View Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.contentView.backgroundColor = UIColor.purpleColor()
        self.contentView.addSubview(self.imageView)
        self.contentView.addSubview(self.numberLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Layout
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.numberLabel.frame = self.bounds
    }
    
    
    // MARK: - Lazy Initialization
    lazy var imageView: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.contentMode = .ScaleAspectFill
        return imageView
    }()
    
    lazy var numberLabel: UILabel = {
        let label: UILabel = UILabel()
        label.textColor = UIColor.whiteColor()
        return label
    }()
    
}
