//
//  FlickrPhoto_PhotoDisplayableTests.swift
//  FlickrDemoTests
//
//  Created by John McIntosh on 10/3/17.
//  Copyright © 2017 John T McIntosh. All rights reserved.
//

@testable import FlickrDemo
import XCTest


class FlickrPhoto_PhotoDisplayableTests: XCTestCase {
    
    func testThumbnailEqualsSource() {
        let url = URL(string: "http://example.com/thumbnail.jpg")!
        let photo = FlickrPhoto.make(source: url)
        let displayable = photo as PhotoDisplayable
        
        XCTAssertEqual(displayable.thumbnail.absoluteString, url.absoluteString)
    }

    func testDateEqualsDateTaken() {
        let dateTaken = Date(timeIntervalSince1970: 100)
        let published = Date(timeIntervalSince1970: 1000)
        let photo = FlickrPhoto.make(dateTaken: dateTaken, published: published)
        let displayable = photo as PhotoDisplayable
        
        XCTAssertEqual(displayable.displayDate, dateTaken)
    }
    
    func testLargeURLGeneration_validThumbnailURL() {
        let url = URL(string: "http://example.com/image_m.jpg")!
        let photo = FlickrPhoto.make(source: url)
        let displayable = photo as PhotoDisplayable
        
        XCTAssertEqual(displayable.large.absoluteString, "http://example.com/image_b.jpg")
    }

    func testLargeURLGeneration_validMediumURL() {
        let url = URL(string: "http://example.com/image_z.jpg")!
        let photo = FlickrPhoto.make(source: url)
        let displayable = photo as PhotoDisplayable
        
        XCTAssertEqual(displayable.large.absoluteString, "http://example.com/image_b.jpg")
    }

    func testLargeURLGeneration_invalidThumbnailURL() {
        let url = URL(string: "http://example.com/image.jpg")!
        let photo = FlickrPhoto.make(source: url)
        let displayable = photo as PhotoDisplayable
        
        XCTAssertEqual(displayable.large.absoluteString, url.absoluteString)
    }
}


private extension FlickrPhoto {
    
    static func make(source: URL = URL(string: "http://example.com")!,
                     dateTaken: Date = Date(),
                     published: Date = Date()) -> FlickrPhoto {
        return FlickrPhoto(
            title: "Sample",
            link: URL(string: "http://example.com")!,
            source: source,
            dateTaken: dateTaken,
            description: "Sample",
            published: published,
            author: "Sample",
            authorId: "1234",
            tags: [])
    }
}
