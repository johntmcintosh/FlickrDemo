//
//  PhotoDetailViewController.swift
//  FlickrDemo
//
//  Created by John McIntosh on 10/3/17.
//  Copyright © 2017 John T McIntosh. All rights reserved.
//

import AlamofireImage
import UIKit


class PhotoDetailViewController: UIViewController {
    
    // MARK: Outlets
    
    @IBOutlet weak var imageView: UIImageView! {
        didSet {
            imageView.setImage(withURL: photo.large, asynchronous: viewConfig.animated)
        }
    }
    
    @IBOutlet weak var titleContainer: UIView!
    
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.text = photo.title
        }
    }
    
    
    // MARK: Properties
    
    let photo: PhotoDisplayable
    let viewConfig: ViewConfig
    
    
    // MARK: Initializers
    
    init(photo: PhotoDisplayable, viewConfig: ViewConfig = .standard()) {
        self.photo = photo
        self.viewConfig = viewConfig
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
