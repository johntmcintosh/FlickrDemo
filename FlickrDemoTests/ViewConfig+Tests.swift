//
//  ViewConfig+Tests.swift
//  FlickrDemoTests
//
//  Created by John McIntosh on 10/4/17.
//  Copyright © 2017 John T McIntosh. All rights reserved.
//

@testable import FlickrDemo
import Foundation


extension ViewConfig {
    
    /// Instance of ViewConfig that's standardized for consistency across screenshot tests.
    static func mock() -> ViewConfig {
        return ViewConfig(
            animated: false,
            timeZone: TimeZone(abbreviation: "CDT")!,
            locale: Locale(identifier: "en_US"))
    }
}
