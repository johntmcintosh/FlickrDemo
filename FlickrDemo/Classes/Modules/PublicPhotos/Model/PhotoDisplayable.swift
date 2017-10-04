//
//  PhotoDisplayable.swift
//  FlickrDemo
//
//  Created by John McIntosh on 10/3/17.
//  Copyright © 2017 John T McIntosh. All rights reserved.
//

import Foundation


protocol PhotoDisplayable {
    
    var title: String { get }
    var thumbnail: URL { get }
    var large: URL { get }
    var date: Date { get }
}