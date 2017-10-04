//
//  FeedGridLayout.swift
//  FlickrDemo
//
//  Created by John McIntosh on 10/4/17.
//  Copyright © 2017 John T McIntosh. All rights reserved.
//

import UIKit


class FeedGridLayout: UICollectionViewFlowLayout {
    
    var numberOfColums: Int = 3 {
        didSet {
            invalidateLayout()
        }
    }

    
    // MARK: Initializers
    
    override init() {
        super.init()
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        minimumInteritemSpacing = 4.0
        minimumLineSpacing = 4.0
        scrollDirection = .vertical
    }
    
    
    // MARK: Layout
    
    override var itemSize: CGSize {
        set {
            // This is a fixed-grid layout, so don't allow custom sizes to be set.
        }
        get {
            guard let collectionView = collectionView else {
                return .zero
            }
            
            let totalWidth = collectionView.bounds.width
            let totalInternalPadding = minimumInteritemSpacing * CGFloat(numberOfColums - 1)
            let widthForItemsOnly = totalWidth - totalInternalPadding
            let itemWidth = widthForItemsOnly / CGFloat(numberOfColums)
            return CGSize(width: itemWidth, height: itemWidth)
        }
    }
}
