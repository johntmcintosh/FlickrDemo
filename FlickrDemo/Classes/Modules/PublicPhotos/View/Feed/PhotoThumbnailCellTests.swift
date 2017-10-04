//
//  PhotoThumbnailCellTests.swift
//  FlickrDemoTests
//
//  Created by John McIntosh on 10/4/17.
//  Copyright © 2017 John T McIntosh. All rights reserved.
//

@testable import FlickrDemo
import SnapshotKit
import XCTest


class PhotoThumbnailCellTests: SnapshotKitTestCase {
    
    override func setUp() {
        super.setUp()
        recordMode = false
    }
    
    func testLandscapeImage() {
        let cell = PhotoThumbnailCell()
        
        cell.imageView.image = UIImage(testImageNamed: "sample-photo-landscape.jpg")
        
        snapshot.fixed(size: CGSize(width: 200.0, height: 200.0)).verify(cell)
    }

    func testPortraitImage() {
        let cell = PhotoThumbnailCell()
        
        cell.imageView.image = UIImage(testImageNamed: "sample-photo-portrait.jpg")
        
        snapshot.fixed(size: CGSize(width: 200.0, height: 200.0)).verify(cell)
    }
}
