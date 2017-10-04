//
//  PhotoDetailViewControllerTests.swift
//  FlickrDemoTests
//
//  Created by John McIntosh on 10/3/17.
//  Copyright © 2017 John T McIntosh. All rights reserved.
//

@testable import FlickrDemo
import SnapshotKit
import XCTest


class PhotoDetailViewControllerTests: SnapshotKitTestCase {
    
    override func setUp() {
        super.setUp()
        recordMode = false
    }
    
    func testLandscapePhotoLoaded() {
        let photo = MockPhoto(title: "Basic photo title", imageName: "sample-photo-landscape")
        let vc = PhotoDetailViewController(photo: photo, animated: false)
        
        snapshot.simulator().verify(vc)
    }

    func testPortraitPhotoLoaded() {
        let photo = MockPhoto(title: "Basic photo title", imageName: "sample-photo-portrait")
        let vc = PhotoDetailViewController(photo: photo, animated: false)
        
        snapshot.simulator().verify(vc)
    }
}


private struct MockPhoto: PhotoDisplayable {
    
    var title: String
    
    var thumbnail: URL {
        return large
    }
    
    var imageName: String
    
    var large: URL {
        let bundle = Bundle(for: MockServer.self)
        return bundle.url(forResource: imageName, withExtension: "jpg", subdirectory: "LocalServerTests")!
    }
    
    var date: Date {
        return Date(timeIntervalSince1970: 0)
    }
}
