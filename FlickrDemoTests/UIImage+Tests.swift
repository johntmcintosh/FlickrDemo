//
//  UIImage+Tests.swift
//  FlickrDemoTests
//
//  Created by John McIntosh on 10/4/17.
//  Copyright © 2017 John T McIntosh. All rights reserved.
//

import UIKit


extension UIImage {
    
    convenience init?(testImageNamed: String) {
        guard let url = URL(testImageNamed: testImageNamed) else {
            return nil
        }
        guard let data = NSData(contentsOf: url) else {
            return nil
        }
        self.init(data: data as Data)
    }
}
