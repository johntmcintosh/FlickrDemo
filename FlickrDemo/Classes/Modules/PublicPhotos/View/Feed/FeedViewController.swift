//
//  FeedViewController.swift
//  FlickrDemo
//
//  Created by John McIntosh on 10/4/17.
//  Copyright © 2017 John T McIntosh. All rights reserved.
//

import UIKit


protocol FeedViewControllerDelegate: class {
    
    func didTriggerRefresh(in viewController: FeedViewController)
    func didSelect(photo: PhotoDisplayable, in viewController: FeedViewController)
}


class FeedViewController: UIViewController {
    
    // MARK: Outlets and Views

    @IBOutlet weak var collectionView: UICollectionView? {
        didSet {
            collectionView?.register(PhotoThumbnailCell.self, forCellWithReuseIdentifier: PhotoThumbnailCell.reuseIdentifier)
            collectionView?.addSubview(refreshControl)
        }
    }
    
    lazy var refreshControl: UIRefreshControl = {
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(refreshTriggered), for: .valueChanged)
        return refresh
    }()
    
    
    // MARK: Properties

    let viewConfig: ViewConfig
    weak var delegate: FeedViewControllerDelegate?
    private(set) var photos: [PhotoDisplayable] = []
    
    
    // MARK: Initializers
    
    init(viewConfig: ViewConfig = .standard()) {
        self.viewConfig = viewConfig
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = NSLocalizedString("Public Flickr Feed", comment: "")
        clearBackButtonTitle()
    }

    
    // MARK: Public
    
    func set(isRefreshing: Bool) {
        if isRefreshing {
            loadViewIfNeeded()
            refreshControl.beginRefreshing()
            if photos.isEmpty {
                let offset = CGPoint(x: 0, y: -refreshControl.bounds.height)
                collectionView?.setContentOffset(offset, animated: viewConfig.animated)
            }
        }
        else {
            refreshControl.endRefreshing()
        }
    }
    
    func set(photos: [PhotoDisplayable]) {
        self.photos = photos
        collectionView?.reloadData()
    }
    
    func show(error: ServerError) {
        // NOTE: In a production app, we would likely want to display errors in an inline
        // view rather than presenting an alert with the message.
        presentOkAlert(message: error.message)
    }
    
    
    // MARK: Actions
    
    @objc func refreshTriggered() {
        delegate?.didTriggerRefresh(in: self)
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
        
        let photo = photos[indexPath.row]
        cell.imageView.setImage(withURL: photo.thumbnail, asynchronous: viewConfig.animated)
        
        return cell
    }
}


extension FeedViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let photo = photos[indexPath.row]
        delegate?.didSelect(photo: photo, in: self)
    }
}


private extension FeedViewController {
    
    func clearBackButtonTitle() {
        navigationItem.backBarButtonItem = UIBarButtonItem()
    }
}
