//
//  ImageViewTestable.swift
//  FlickrDemo
//
//  Created by John McIntosh on 10/4/17.
//  Copyright © 2017 John T McIntosh. All rights reserved.
//

import UIKit


protocol ImageViewTestable {
    
    func setImage(withURL: URL?, asynchronous: Bool)
}


extension UIImageView: ImageViewTestable {
    
    func setImage(withURL url: URL?, asynchronous: Bool) {
        guard let url = url else {
            image = nil
            return
        }
        
        guard asynchronous else {
            guard let data = try? Data(contentsOf: url) else { return }
            image = UIImage(data: data)
            return
        }
        
        af_setImage(withURL: url, placeholderImage: UIImage(), imageTransition: .crossDissolve(0.3))
    }
}
