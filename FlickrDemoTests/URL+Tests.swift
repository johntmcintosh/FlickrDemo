//
//  URL+Tests.swift
//  FlickrDemoTests
//
//  Created by John McIntosh on 10/4/17.
//  Copyright © 2017 John T McIntosh. All rights reserved.
//

import Foundation


extension URL {
    
    init?(testImageNamed: String) {
        let imageName = (testImageNamed as NSString).deletingPathExtension
        let imageExtension = (testImageNamed as NSString).pathExtension
        guard let url = Bundle(for: MockTestClass.self).url(forResource: imageName, withExtension: imageExtension, subdirectory: "LocalServerTests") else {
            return nil
        }
        self = url
    }
}
