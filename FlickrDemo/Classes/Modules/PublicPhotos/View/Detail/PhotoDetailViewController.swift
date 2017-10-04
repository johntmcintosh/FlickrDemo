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
            guard animated else {
                guard let data = try? Data(contentsOf: photo.large) else { return }
                imageView.image = UIImage(data: data)
                return
            }
            imageView.af_setImage(withURL: photo.large, imageTransition: .crossDissolve(0.3))
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
    let animated: Bool
    
    
    // MARK: Initializers
    
    init(photo: PhotoDisplayable, animated: Bool = true) {
        self.photo = photo
        self.animated = animated
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
