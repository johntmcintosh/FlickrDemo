//
//  PhotoTests.swift
//  FlickrDemoTests
//
//  Created by John McIntosh on 10/3/17.
//  Copyright © 2017 John T McIntosh. All rights reserved.
//

@testable import FlickrDemo
import SwiftyJSON
import XCTest


class PhotoTests: XCTestCase {
    
    func testPhotoParsing_valid() {
        let json = jsonFromTestFile("services.feeds.photos_public.gne...success[photo].json")
        let photo = Photo(json: json)!
        
        let dateFormatter = ISO8601DateFormatter()
        
        XCTAssertEqual(photo.title, "Sample Photo")
        XCTAssertEqual(photo.link.absoluteString, "https://www.flickr.com/photos/12345/")
        XCTAssertEqual(photo.source.absoluteString, "https://farm5.staticflickr.com/12345_m.jpg")
        XCTAssertEqual(photo.dateTaken, dateFormatter.date(from: "2017-10-03T17:01:40-08:00"))
        XCTAssertEqual(photo.description, "<p>Sample HTML description</p>")
        XCTAssertEqual(photo.published, dateFormatter.date(from: "2017-10-04T00:01:40Z"))
        XCTAssertEqual(photo.author, "nobody@flickr.com (\"user1234\")")
        XCTAssertEqual(photo.tags, ["tag1", "tag2"])
    }
}
