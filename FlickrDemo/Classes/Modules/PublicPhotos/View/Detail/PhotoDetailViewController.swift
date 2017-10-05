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
    
    @IBOutlet var detailOnscreenConstraint: NSLayoutConstraint!
    @IBOutlet weak var detailContainer: UIView!
    
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.isHidden = photo.displayTitle.isEmpty
            titleLabel.text = photo.displayTitle
        }
    }

    @IBOutlet weak var dateLabel: UILabel! {
        didSet {
            dateLabel.text = formatter.string(from: photo.displayDate)
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
    
    
    // MARK: Overrides
    
    override var prefersStatusBarHidden: Bool {
        return navigationController?.isNavigationBarHidden ?? false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addShowHideDetailsTapGesture()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
    
    
    // MARK: Actions
    
    @objc func viewTapped() {
        guard let isNavigationHidden = navigationController?.isNavigationBarHidden else { return }
        setDetailView(hidden: isNavigationHidden, animated: viewConfig.animated)
        setNeedsStatusBarAppearanceUpdate()
    }
}


private extension PhotoDetailViewController {
    
    func addShowHideDetailsTapGesture() {
        navigationController?.barHideOnTapGestureRecognizer.addTarget(self, action: #selector(viewTapped))
    }
    
    func setDetailView(hidden: Bool, animated: Bool) {
        self.detailOnscreenConstraint.isActive = !hidden
        
        let duration = (animated) ? 0.3 : 0.0
        UIView.animate(withDuration: duration) {
            self.view.layoutIfNeeded()
        }
    }
}
