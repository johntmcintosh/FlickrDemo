//
//  MockPhoto.swift
//  FlickrDemoTests
//
//  Created by John McIntosh on 10/4/17.
//  Copyright © 2017 John T McIntosh. All rights reserved.
//

@testable import FlickrDemo
import Foundation


struct MockPhoto: PhotoDisplayable {
    
    var displayTitle: String
    
    var thumbnail: URL {
        return large
    }
    
    var imageName: String
    
    var large: URL {
        return URL(testImageNamed: imageName)!
    }
    
    var displayDate: Date {
        return Date(timeIntervalSince1970: 0)
    }
}


extension MockPhoto {
    
    static func make() -> MockPhoto {
        return MockPhoto(displayTitle: "Basic photo title", imageName: "sample-photo-landscape.jpg")
    }
}
