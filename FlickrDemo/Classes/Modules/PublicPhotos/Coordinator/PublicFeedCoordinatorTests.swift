//
//  PublicFeedCoordinatorTests.swift
//  FlickrDemoTests
//
//  Created by John McIntosh on 10/4/17.
//  Copyright © 2017 John T McIntosh. All rights reserved.
//

@testable import FlickrDemo
import Result
import XCTest


class PublicFeedCoordinatorTests: XCTestCase {
    
    private var navigtionController: UINavigationController!
    private var feedService: MockFeedService!
    private var coordinator: PublicFeedCoordinator!

    override func setUp() {
        super.setUp()
        
        navigtionController = UINavigationController()
        UIApplication.shared.keyWindow?.rootViewController = navigtionController
        
        feedService = MockFeedService()
        coordinator = PublicFeedCoordinator(navigationController: navigtionController, feedService: feedService)
        coordinator.start()
    }
    
    // MARK: Start
    
    func testStart_presentsList() {
        XCTAssertEqual(navigtionController.viewControllers.count, 1)
        
        XCTAssertTrue(navigtionController.topViewController is FeedViewController)
    }
    
    func testStart_autoFetches() {
        XCTAssertTrue(feedService.fetchTriggered)
    }
    
    
    // MARK: Feed fetching
    
    func testFetchingFeedSuccess_updatesViewController() {
        feedService.nextResponse = .success([MockPhoto.make()])
        
        let expectation = self.expectation(description: "Completion expectation")
        coordinator.fetchPublicFeed {
            XCTAssertEqual(self.coordinator.feedVC.photos.count, 1)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1.0)
    }

    func testFetchingFeedFailure_presentsError() {
        feedService.nextResponse = .failure(ServerError(NSError.make()))
        
        let expectation = self.expectation(description: "Completion expectation")
        coordinator.fetchPublicFeed {
            XCTAssertTrue(self.coordinator.feedVC.presentedViewController is UIAlertController)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1.0)
    }
}


private class MockFeedService: PublicFeedServicing {
    
    var fetchTriggered: Bool = false
    var nextResponse: Result<[PhotoDisplayable], ServerError>?
    
    func fetchPublicFeed(completion: @escaping (Result<[PhotoDisplayable], ServerError>) -> ()) {
        fetchTriggered = true
        if let response = nextResponse {
            DispatchQueue.main.async {
                completion(response)
            }
        }
    }
}


private extension NSError {
    
    static func make() -> NSError {
        let userInfo = [NSLocalizedDescriptionKey: "Mock error"]
        return NSError(domain: "com.flickrdemo.tests", code: 1, userInfo: userInfo)
    }
}
