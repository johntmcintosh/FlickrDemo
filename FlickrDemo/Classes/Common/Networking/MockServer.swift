//
//  MockServer.swift
//  FlickrDemo
//
//  Created by John McIntosh on 10/3/17.
//  Copyright © 2017 John T McIntosh. All rights reserved.
//

@testable import FlickrDemo
import Foundation
import Result
import SwiftyJSON
import XCTest


/// Implementation of the Server protocol for use in unit tests. It supports programmatically specifying which
/// response to return for the next request and provides some helpers around XCTAsserts.
class MockServer: Server {
    
    struct Request {
        let path: String
        let parameters: [URLQueryItem]?
    }
    
    var lastRequest: Request?
    var nextResponse: Result<ServerResponse, ServerError>?
    
    var baseUrl: URL { return URL(string: "http://example.com")! }
    
    func get(to path: String, parameters: [URLQueryItem]?, completion: @escaping (Result<ServerResponse, ServerError>) -> ()) {
        lastRequest = Request(path: path, parameters: parameters)
        completion(nextResponse ?? .success(ServerResponse(JSON(""))))
    }
    
    func queueNextResponse(localTestFile: String) {
        let pathExtension = (localTestFile as NSString).pathExtension
        let fileName = (localTestFile as NSString).deletingPathExtension
        
        let bundle = Bundle(for: MockServer.self)
        let url = bundle.url(forResource: fileName, withExtension: pathExtension, subdirectory: "LocalServerTests")!
        let data = try! Data(contentsOf: url, options: .alwaysMapped)
        let json = JSON(data: data)
        nextResponse = .success(ServerResponse(json))
    }
    
    func assertLastRequestEquals(_ lastRequest: String, file: StaticString = #file, line: UInt = #line) {
        XCTAssertEqual(self.lastRequest?.path, lastRequest, file: file, line: line)
    }
    
    func assertLastRequestParameterEqual(_ parameter: String, _ value: String?, file: StaticString = #file, line: UInt = #line) {
        guard let parameters = lastRequest?.parameters else {
            XCTFail("There were no parameters in the last request", file: file, line: line)
            return
        }
        
        guard let queryItem = parameters.first(where: { $0.name == parameter }) else {
            XCTFail("The parameter '\(parameter)' was not in the last request.", file: file, line: line)
            return
        }
        
        XCTAssertEqual(queryItem.value, value, file: file, line: line)
    }
}
