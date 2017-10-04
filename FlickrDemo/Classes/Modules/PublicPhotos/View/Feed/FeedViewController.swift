//
//  FeedViewController.swift
//  FlickrDemo
//
//  Created by John McIntosh on 10/4/17.
//  Copyright © 2017 John T McIntosh. All rights reserved.
//

import UIKit


class FeedViewController: UIViewController {
    
    // MARK: Outlets

    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.register(PhotoThumbnailCell.self, forCellWithReuseIdentifier: PhotoThumbnailCell.reuseIdentifier)
        }
    }
    
    
    // MARK: Properties

    let animated: Bool
    var photos: [PhotoDisplayable] = []
    
    
    // MARK: Initializers
    
    init(animated: Bool = true) {
        self.animated = animated
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = NSLocalizedString("Public Flickr Feed", comment: "")
    }
}


extension FeedViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoThumbnailCell.reuseIdentifier, for: indexPath) as! PhotoThumbnailCell
        
        cell.contentView.backgroundColor = .green
        let photo = photos[indexPath.row]
        cell.imageView.setImage(withURL: photo.thumbnail, asynchronous: animated)
        
        return cell
    }
}


extension FeedViewController: UICollectionViewDelegate {
    
}
