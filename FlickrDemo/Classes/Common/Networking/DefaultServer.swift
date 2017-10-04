//
//  DefaultServer.swift
//  FlickrDemo
//
//  Created by John McIntosh on 10/2/17.
//  Copyright © 2017 John T McIntosh. All rights reserved.
//

import Foundation
import Result
import SwiftyJSON


/// A basic sample implementaiton of a server the communicated with the network. Depending on the server
/// that is being connected to, we could extend this to support custom security requirements, auto-logout,
/// SSL Pinning, etc.
class DefaultServer: Server {
    
    // NOTE: If we needed to consider staging vs production endpoints, I'd likely pass in the desired base url
    // through the server object's initializer rather than declaring it here in the server implementation.
    var baseUrl: URL {
        return URL(string: "https://api.flickr.com")!
    }
    
    private let session: URLSession
    
    init(protocolClass: URLProtocol.Type? = nil) {
        let configuration = URLSessionConfiguration.default
        if let protocolClass = protocolClass {
            configuration.protocolClasses = [protocolClass]
        }
        self.session = URLSession(configuration: configuration)
    }
    
    // NOTE: This is a basic implemention of triggering a network call that makes several assumptions.
    // For example:
    // - The response is assumed to be valid JSON. We could add additional validation here.
    // - The response is always assumed to be a 200 response. We could add additional handling here
    //   to treat non-200 responses as errors and return a custom error.
    // - This assumes that we don't need to expose the status code outside of the server implementation.
    //   If we did, we could include it with the ServerResponse object.
    func get(to path: String, parameters: [URLQueryItem]?, completion: @escaping (Result<ServerResponse, ServerError>) -> ()) {
        let inputParameters = parameters ?? []
        let parameters = self.appendStandardParameters(to: inputParameters)

        guard let url = self.url(forPath: path, parameters: parameters) else {
            DispatchQueue.main.async {
                completion(.failure(ServerError(NSLocalizedString("Unable to generate a valid URL for the network request.", comment: ""))))
            }
            return
        }
        
        session.dataTask(with: url, completionHandler: { (data, urlResponse, error) in
            guard error == nil else {
                DispatchQueue.main.async {
                    completion(.failure(ServerError(error!)))
                }
                return
            }
            
            // NOTE: We should generally have a value for data if we don't have an error object, but this guard gives
            // us compile-time assurance before we continue.
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(.failure(ServerError(NSLocalizedString("No data was received from the server.", comment: ""))))
                }
                return
            }
            
            let response = ServerResponse(JSON(data))
            DispatchQueue.main.async {
                completion(.success(response))
            }
        }).resume()
    }
}


private extension DefaultServer {
    
    func appendStandardParameters(to parameters: [URLQueryItem]) -> [URLQueryItem] {
        var queryItems = parameters
        queryItems.append(URLQueryItem(name: "format", value: "json"))
        queryItems.append(URLQueryItem(name: "nojsoncallback", value: "1"))
        return queryItems
    }
    
    func url(forPath path: String, parameters: [URLQueryItem]?) -> URL? {
        guard let url = URL(string: path, relativeTo: baseUrl),
            var components = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
                return nil
        }
        
        components.queryItems = parameters
        return components.url
    }
}
