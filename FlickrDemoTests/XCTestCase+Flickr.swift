//
//  XCTestCase+Flickr.swift
//  FlickrDemoTests
//
//  Created by John McIntosh on 10/3/17.
//  Copyright © 2017 John T McIntosh. All rights reserved.
//

import SwiftyJSON
import XCTest


extension XCTestCase {
    
    func jsonFromTestFile(_ localTestFile: String) -> JSON {
        let pathExtension = (localTestFile as NSString).pathExtension
        let fileName = (localTestFile as NSString).deletingPathExtension
        
        let bundle = Bundle(for: MockServer.self)
        let url = bundle.url(forResource: fileName, withExtension: pathExtension, subdirectory: "LocalServerTests")!
        let data = try! Data(contentsOf: url, options: .alwaysMapped)
        let json = JSON(data: data)
        return json
    }
}
