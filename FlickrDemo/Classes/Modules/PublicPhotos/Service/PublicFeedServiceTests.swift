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
    
    func testFetchEvents_request() {
        let expectation = self.expectation(description: "Completion expectation")
        service.fetchPublicFeed() { result in
            self.server.assertLastRequestEquals(Endpoint.Feeds.publicPhotos)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1.0)
    }
    
    func testFetchEvents_responseSuccess() {
        server.queueNextResponse(localTestFile: "services.feeds.photos_public.gne...success.json")
        
        let expectation = self.expectation(description: "Completion expectation")
        service.fetchPublicFeed() { result in
            let events = try! result.dematerialize()
            // TODO: zero is only correct until parsing is implemented
            XCTAssertEqual(events.count, 0)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1.0)
    }
    
    func testFetchEvents_responseError() {
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

