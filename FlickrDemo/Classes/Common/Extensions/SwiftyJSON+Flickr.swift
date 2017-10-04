//
//  SwiftyJSON+Flickr.swift
//  FlickrDemo
//
//  Created by John McIntosh on 10/3/17.
//  Copyright © 2017 John T McIntosh. All rights reserved.
//

import Foundation
import SwiftyJSON


extension JSON {

    // MARK: Dates
    
    private static var iso8601ParsingFormatter = ISO8601DateFormatter()

    var dateFromISO8601Sting: Date? {
        get {
            return JSON.iso8601ParsingFormatter.date(from: stringValue)
        }
    }

    
    // MARK: HTML
    
    var html: HTML? {
        get {
            return string
        }
    }
    
    
    // MARK: Arrays
    
    func arrayValueForType<T: JSONInstantiable>(_ type: T.Type) -> [T]? {
        return arrayValueForType(type, initializer: { (json) -> (T)? in
            return T(json: json)
        })
    }
    
    func arrayValueForType<T>(_ type: T.Type, initializer: (_ json: JSON) -> (T)?) -> [T]? {
        var array: [T] = []
        for jsonItem in self.arrayValue {
            if let item = initializer(jsonItem) {
                array.append(item)
            }
        }
        if (array.count == 0) { return nil }
        return array
    }
}
