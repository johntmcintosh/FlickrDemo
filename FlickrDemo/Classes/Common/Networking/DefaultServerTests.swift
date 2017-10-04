//
//  DefaultServerTests.swift
//  FlickrDemoTests
//
//  Created by John McIntosh on 10/2/17.
//  Copyright © 2017 John T McIntosh. All rights reserved.
//

@testable import FlickrDemo
import Result
import SwiftyJSON
import XCTest


class DefaultServerTests: XCTestCase {
    
    var server: DefaultServer!
    
    override func setUp() {
        super.setUp()
        server = DefaultServer(protocolClass: TestURLProtocol.self)
    }
    
    override func tearDown() {
        TestURLProtocol.lastRequest = nil
        TestURLProtocol.nextResponse = nil
        super.tearDown()
    }
    
    
    // MARK: Request
    
    func testNetworkRequest_noCustomParameters() {
        let expectation = self.expectation(description: "completion expectation")
        server.get(to: "endpoint", parameters: nil) { result in
            let url = TestURLProtocol.lastRequest!.url!
            XCTAssertEqual(url.absoluteString, "https://api.flickr.com/endpoint?format=json&nojsoncallback=1")
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1.0)
    }
    
    func testNetworkRequest_withCustomParameters() {
        let parameters = [
            URLQueryItem(name: "key", value: "value string")
        ]
        
        let expectation = self.expectation(description: "completion expectation")
        server.get(to: "endpoint", parameters: parameters) { result in
            let url = TestURLProtocol.lastRequest!.url!
            XCTAssertEqual(url.absoluteString, "https://api.flickr.com/endpoint?key=value%20string&format=json&nojsoncallback=1")
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1.0)
    }
    
    
    // MARK: Response
    
    func testResponseSuccessful() {
        let url = URL(string: "https://api.flickr.com/endpoint")!
        let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)!
        
        let responseBody: [String: Any] = ["success": true]
        let data = try! JSONSerialization.data(withJSONObject: responseBody, options: .prettyPrinted)
        TestURLProtocol.nextResponse = TestURLProtocol.Response.success(response, data)
        
        let expectation = self.expectation(description: "completion expectation")
        server.get(to: "endpoint", parameters: nil) { result in
            let response = try! result.dematerialize()
            let json = response.json
            XCTAssertEqual(json["success"].bool, true)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1.0)
    }
    
    func testResponseError() {
        let userInfo = [NSLocalizedDescriptionKey: "The Internet connection appears to be offline."]
        let offlineError = NSError(domain: "NSURLErrorDomain", code: -1099, userInfo: userInfo)
        TestURLProtocol.nextResponse = TestURLProtocol.Response.error(offlineError)
        
        let expectation = self.expectation(description: "completion expectation")
        server.get(to: "endpoint", parameters: nil) { result in
            let error = result.error!
            XCTAssertEqual(error.message, "The Internet connection appears to be offline.")
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1.0)
    }
}


private class TestURLProtocol: URLProtocol {
    
    static var lastRequest: URLRequest?
    static var nextResponse: Response?
    
    enum Response {
        case success(URLResponse, Data)
        case error(Error)
    }
    
    override class func canInit(with request: URLRequest) -> Bool {
        lastRequest = request
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        DispatchQueue.main.async {
            guard let response = TestURLProtocol.nextResponse else {
                self.client?.urlProtocolDidFinishLoading(self)
                return
            }
            
            switch response {
            case .success(let urlResponse, let data):
                self.client?.urlProtocol(self, didReceive: urlResponse, cacheStoragePolicy: .notAllowed)
                self.client?.urlProtocol(self, didLoad: data)
                self.client?.urlProtocolDidFinishLoading(self)
            case .error(let error):
                self.client?.urlProtocol(self, didFailWithError: error)
            }
        }
    }
    
    override func stopLoading() {
        // Nothing to do
    }
}
