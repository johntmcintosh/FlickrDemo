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

    @IBOutlet weak var dateLabel: UILabel! {
        didSet {
            dateLabel.text = formatter.string(from: photo.date)
        }
    }

    
    // MARK: Properties
    
    let photo: PhotoDisplayable
    let viewConfig: ViewConfig
    
    private lazy var formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeZone = viewConfig.timeZone
        formatter.locale = viewConfig.locale
        formatter.dateStyle = .medium
        formatter.timeStyle = .medium
        return formatter
    }()
    
    
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
