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
        recordMode = false
    }
    
    func testBasic() {
        let vc = FeedViewController(animated: false)
        let navC = UINavigationController(rootViewController: vc)

        vc.loadViewIfNeeded()
        vc.set(photos: [
            MockPhoto(title: "Basic photo title", imageName: "sample-photo-landscape.jpg"),
            MockPhoto(title: "Basic photo title", imageName: "sample-photo-portrait.jpg"),
            MockPhoto(title: "Basic photo title", imageName: "sample-photo-landscape.jpg"),
            MockPhoto(title: "Basic photo title", imageName: "sample-photo-portrait.jpg"),
        ])

        snapshot.simulator().verify(navC)
    }
}
