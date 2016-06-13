//
//  DecodeOperation.swift
//  Photos-Demo
//
//  Created by Joseph Kiley on 6/13/16.
//  Copyright © 2016 Joseph Kiley. All rights reserved.
//

import UIKit

class DecodeOperation: NSOperation {
    
    let image: UIImage
    let decoder: ImageDecoder
    let completion: (UIImage -> Void)
    
    init(image: UIImage, decoder: ImageDecoder, completion: (UIImage -> Void)) {
        self.image = image
        self.decoder = decoder
        self.completion = completion
    }
    
    override func main() {
        if cancelled {
            return
        }
        
        let decodedImage = decoder.decode(image)
        
        if cancelled {
            return
        }
        
        NSOperationQueue.mainQueue().addOperationWithBlock { 
            self.completion(decodedImage)
        }
    }

}
