//
//  ImageRequest.swift
//  Photos-Demo
//
//  Created by Joseph Kiley on 6/13/16.
//  Copyright © 2016 Joseph Kiley. All rights reserved.
//

import UIKit
import Alamofire

class ImageRequest {
    
    var decodeOperation: NSOperation?
    var request: Request
    
    init(request: Request) {
        self.request = request
    }
    
    func cancel() {
        decodeOperation?.cancel()
        self.request.cancel()
    }

}
