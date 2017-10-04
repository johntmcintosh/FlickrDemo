//
//  PublicFeedServiceTests.swift
//  FlickrDemoTests
//
//  Created by John McIntosh on 10/3/17.
//  Copyright © 2017 John T McIntosh. All rights reserved.
//

@testable import FlickrDemo
import XCTest


class PublicFeedServiceTests: XCTestCase {
    
    var server: MockServer!
    var service: PublicFeedService!
    
    
    override func setUp() {
        super.setUp()
        server = MockServer()
        service = PublicFeedService(server: server)
    }
    
    func testFetch_request() {
        let expectation = self.expectation(description: "Completion expectation")
        service.fetchPublicFeed() { result in
            self.server.assertLastRequestEquals(Endpoint.Feeds.publicPhotos)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1.0)
    }
    
    func testFetch_responseSuccess() {
        server.queueNextResponse(localTestFile: "services.feeds.photos_public.gne...success.json")
        
        let expectation = self.expectation(description: "Completion expectation")
        service.fetchPublicFeed() { result in
            let items = try! result.dematerialize()
            XCTAssertEqual(items.count, 20)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1.0)
    }
    
    func testFetch_responseError() {
        server.nextResponse = .failure(ServerError("error message"))
        
        let expectation = self.expectation(description: "Completion expectation")
        service.fetchPublicFeed() { result in
            let error = result.error!
            XCTAssertEqual(error.message, "error message")
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1.0)
    }
}

