//
//  CountdownListFlowLayout.swift
//  StylesheetsInSwiftExample
//
//  Created by Marc Zobec on 2016-05-28.
//  Copyright © 2016 Marc Zobec. All rights reserved.
//

import UIKit

class CountdownListFlowLayout: UICollectionViewFlowLayout {
    
    override init() {
        super.init()
        setupLayout()
    }
    
    func setupLayout() {
        minimumInteritemSpacing = 32.0
        minimumLineSpacing = 32.0
        sectionInset = UIEdgeInsetsMake(32.0, 32.0, 32.0, 32.0)
    }
    
    override var itemSize: CGSize {
        set { super.itemSize = newValue }
        get {
            let numberOfColumns: CGFloat = 2
            guard let collectionView = collectionView where collectionView.bounds.width > 0 else { return CGSizeZero }
            let itemWidth = (collectionView.bounds.width - ((numberOfColumns + 1) * minimumInteritemSpacing)) / numberOfColumns
            return CGSizeMake(itemWidth, itemWidth)
        }
    }
    
    required init?(coder aDecoder: NSCoder) { return nil }
    
}
