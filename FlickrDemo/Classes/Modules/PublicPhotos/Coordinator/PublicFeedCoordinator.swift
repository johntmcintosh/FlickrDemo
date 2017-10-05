//
//  PublicFeedCoordinator.swift
//  FlickrDemo
//
//  Created by John McIntosh on 10/4/17.
//  Copyright © 2017 John T McIntosh. All rights reserved.
//

import Foundation
import UIKit


/// The coordinator is a "flow controller" type object responsible for coordinating
/// access to data from external sources and presentation of views to the user.
/// Pulling this out of the view controller allows the view controllers to be
/// more straightforward, more data-driver, and more testable.
class PublicFeedCoordinator {
    
    fileprivate let navigationController: UINavigationController
    fileprivate let feedService: PublicFeedServicing
    
    lazy var feedVC: FeedViewController = {
        let vc = FeedViewController()
        vc.delegate = self
        return vc
    }()
    
    
    // MARK: Initializer
    
    init(navigationController: UINavigationController, feedService: PublicFeedServicing = PublicFeedService()) {
        self.navigationController = navigationController
        self.feedService = feedService
    }
    
    
    // MARK: Primary
    
    func start() {
        navigationController.setViewControllers([feedVC], animated: false)
        fetchPublicFeed()
    }
    
    func fetchPublicFeed(completion: (() -> ())? = nil) {
        feedVC.set(isRefreshing: true)
        feedService.fetchPublicFeed { result in
            self.feedVC.set(isRefreshing: false)
            switch result {
            case .success(let photos):
                self.feedVC.set(photos: photos)
                completion?()
            case .failure(let error):
                self.feedVC.show(error: error)
                completion?()
            }
        }
    }
}


extension PublicFeedCoordinator: FeedViewControllerDelegate {
    
    func didTriggerRefresh(in viewController: FeedViewController) {
        fetchPublicFeed()
    }
    
    func didSelect(photo: PhotoDisplayable, in viewController: FeedViewController) {
        let vc = PhotoDetailViewController(photo: photo)
        navigationController.pushViewController(vc, animated: true)
    }
}
