//
//  FlickrPhoto.swift
//  FlickrDemo
//
//  Created by John McIntosh on 10/3/17.
//  Copyright © 2017 John T McIntosh. All rights reserved.
//

import Foundation
import SwiftyJSON


/// Model representation of a photo from the Flickr API.
struct FlickrPhoto {
    
    var title: String
    var link: URL
    var source: URL
    var dateTaken: Date
    var description: HTML
    var published: Date
    var author: String
    var authorId: String
    var tags: [String]
}


// NOTE: As of Swift 4, I would replace this `JSONInstantiable` pattern with the now-system-provided Codable
// protocol. However, I haven't had a chance yet to work with that pattern, so I'm using the pattern I have
// traditionally used for now.
extension FlickrPhoto: JSONInstantiable {

    init?(json: JSON) {
        guard let title = json["title"].string,
            let link = json["link"].url,
            let source = json["media"]["m"].url,
            let dateTaken = json["date_taken"].dateFromISO8601Sting,
            let description = json["description"].html,
            let published = json["published"].dateFromISO8601Sting,
            let author = json["author"].string,
            let authorId = json["author_id"].string else {
                return nil
        }
        
        self.title = title
        self.link = link
        self.source = source
        self.dateTaken = dateTaken
        self.description = description
        self.published = published
        self.author = author
        self.authorId = authorId
        self.tags = json["tags"].stringValue.components(separatedBy: .whitespaces)
    }
}
