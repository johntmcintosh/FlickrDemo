//
//  Photo+PhotoDisplayable.swift
//  FlickrDemo
//
//  Created by John McIntosh on 10/3/17.
//  Copyright © 2017 John T McIntosh. All rights reserved.
//

import Foundation


extension FlickrPhoto: PhotoDisplayable {

    var displayTitle: String {
        return title.trimmingCharacters(in: .whitespaces)
    }
    
    var thumbnail: URL {
        return source
    }
    
    // NOTE: According to the [photo url documentation](https://www.flickr.com/services/api/misc.urls.html),
    // large format urls can be generated by modifying the size suffix at the trailing
    // end of the url.
    var large: URL {
        guard let regex = try? NSRegularExpression(pattern: "_[mstzb].jpg$", options: .caseInsensitive) else {
            return source
        }
        
        let input = source.absoluteString
        let range = NSMakeRange(0, input.characters.count)
        let transformedString = regex.stringByReplacingMatches(in: input, options: [], range: range, withTemplate: "_b.jpg")
        
        guard let large = URL(string: transformedString) else {
            return source
        }
        
        return large
    }
    
    var displayDate: Date {
        return dateTaken
    }
}
