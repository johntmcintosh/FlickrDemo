//
//  ViewConfig.swift
//  FlickrDemo
//
//  Created by John McIntosh on 10/4/17.
//  Copyright © 2017 John T McIntosh. All rights reserved.
//

import Foundation


/// Simple struct for passing configuration into view objects while allowing for dependency injection in unit tests.
struct ViewConfig {
    
    var animated: Bool
    var timeZone: TimeZone
    var locale: Locale
}


extension ViewConfig {
    
    static func standard() -> ViewConfig {
        return ViewConfig(animated: true, timeZone: .current, locale: .current)
    }
}
