//
//  FeedViewControllerTests.swift
//  FlickrDemoTests
//
//  Created by John McIntosh on 10/4/17.
//  Copyright © 2017 John T McIntosh. All rights reserved.
//

@testable import FlickrDemo
import SnapshotKit
import XCTest


class FeedViewControllerTests: SnapshotKitTestCase {
    
    override func setUp() {
        super.setUp()
        recordMode = true
    }
    
    func testBasic() {
        let vc = FeedViewController(animated: false)
        vc.photos = [
            MockPhoto(title: "Basic photo title", imageName: "sample-photo-landscape.jpg"),
            MockPhoto(title: "Basic photo title", imageName: "sample-photo-portrait.jpg"),
            MockPhoto(title: "Basic photo title", imageName: "sample-photo-landscape.jpg"),
            MockPhoto(title: "Basic photo title", imageName: "sample-photo-portrait.jpg"),
        ]
        let navC = UINavigationController(rootViewController: vc)
        
        snapshot.simulator().verify(navC)
    }
}


private struct MockPhoto: PhotoDisplayable {
    
    var title: String
    
    var thumbnail: URL {
        return large
    }
    
    var imageName: String
    
    var large: URL {
        return URL(testImageNamed: imageName)!
    }
    
    var date: Date {
        return Date(timeIntervalSince1970: 0)
    }
}

