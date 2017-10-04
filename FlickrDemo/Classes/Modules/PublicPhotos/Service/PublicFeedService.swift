//
//  PublicFeedService.swift
//  FlickrDemo
//
//  Created by John McIntosh on 10/3/17.
//  Copyright © 2017 John T McIntosh. All rights reserved.
//

import Foundation
import Result


/// Service object for fetching photos from the public feed.
class PublicFeedService {
    
    let server: Server
    
    init(server: Server) {
        self.server = server
    }
    
    func fetchPublicFeed(completion: @escaping (Result<[Photo], ServerError>) -> ()) {
        server.get(to: Endpoint.Feeds.publicPhotos, parameters: nil) { result in
            switch result {
            case .success(let response):
                // TODO: Implement response parsing
                completion(.success([]))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
