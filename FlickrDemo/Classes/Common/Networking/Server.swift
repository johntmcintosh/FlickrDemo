//
//  Server.swift
//  FlickrDemo
//
//  Created by John McIntosh on 10/2/17.
//  Copyright © 2017 John T McIntosh. All rights reserved.
//

import Foundation
import Result
import SwiftyJSON


/// Protocol interface for objects that facilitate communication with the network
protocol Server {
    
    var baseUrl: URL { get }
    
    func get(
        to path: String,
        parameters: [URLQueryItem]?,
        completion: @escaping (Result<ServerResponse, ServerError>) -> ())
}


/// Type representing the data returned from a successful network call.
struct ServerResponse {
    
    var json: JSON
    
    init(_ json: JSON) {
        self.json = json
    }
}


/// Type representing the data returned from a failed network call.
struct ServerError: Error {
    
    var message: String
    
    init(_ message: String) {
        self.message = message
    }
    
    init(_ error: Error) {
        self.message = error.localizedDescription
    }
}
