//
//  HomepageViewController.swift
//  Photos-Demo
//
//  Created by Joseph Kiley on 6/7/16.
//  Copyright © 2016 Joseph Kiley. All rights reserved.
//

import UIKit

class HomepageViewController: UIViewController {
    
    // MARK: - Variables
    var homepageCollectionView: HomepageCollectionView = HomepageCollectionView()
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.redColor()
        
        self.view.addSubview(self.homepageCollectionView)
        
    }
    
    // MARK: - Layout
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.homepageCollectionView.frame = self.view.bounds
    }

}
