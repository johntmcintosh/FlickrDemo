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
        let photo = MockPhoto(title: "Basic photo title", imageName: "sample-photo-landscape.jpg")
        let vc = PhotoDetailViewController(photo: photo, viewConfig: .mock())
        let navC = UINavigationController(rootViewController: vc)
        
        snapshot.simulator().verify(navC)
    }

    func testPortraitPhotoLoaded() {
        let photo = MockPhoto(title: "Basic photo title", imageName: "sample-photo-portrait.jpg")
        let vc = PhotoDetailViewController(photo: photo, viewConfig: .mock())
        let navC = UINavigationController(rootViewController: vc)
        
        snapshot.simulator().verify(navC)
    }

    func testMultilineTitle() {
        let photo = MockPhoto(title: "Cras id massa non enim elementum dignissim ut in nisl. Morbi euismod porttitor nibh, eget scelerisque massa tempus et. Donec non ligula vel augue efficitur rhoncus.", imageName: "sample-photo-portrait.jpg")
        let vc = PhotoDetailViewController(photo: photo, viewConfig: .mock())
        let navC = UINavigationController(rootViewController: vc)
        
        snapshot.simulator().verify(navC)
    }
}
