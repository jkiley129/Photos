//
//  ImageItem.swift
//  Photos-Demo
//
//  Created by Joseph Kiley on 6/10/16.
//  Copyright © 2016 Joseph Kiley. All rights reserved.
//

import UIKit

class ImageItem: NSObject {
    
    // MARK: - Variables
    var imageURL: String = ""
    var imageName: String = ""
    var imageDescription: String = ""
    var imageData: NSData?
    
    init(imageURL: String, imageName: String, imageDescription: String) {
        self.imageURL = imageURL
        self.imageName = imageName
        self.imageDescription = imageDescription
    }
    
    // MARK: - Initialization
    required init?(JSON: [String : AnyObject]) {
        if let imageURL: String = JSON["imageURL"] as? String {
            self.imageURL = imageURL
        }
        if let imageName: String = JSON["imageName"] as? String {
            self.imageName = imageName
        }
        if let imageDescription: String = JSON["imageDescription"] as? String {
            self.imageDescription = imageDescription
        }
    }

}
