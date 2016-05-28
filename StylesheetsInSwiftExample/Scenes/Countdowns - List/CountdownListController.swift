//
//  CountdownListController.swift
//  StylesheetsInSwiftExample
//
//  Created by Marc Zobec on 2016-05-28.
//  Copyright © 2016 Marc Zobec. All rights reserved.
//

import UIKit

struct CountdownListSceneTransitions {
    let showCountdown: (Countdown) -> Void
}

class CountdownListController: UICollectionViewController {
    
    let sceneTransitions: CountdownListSceneTransitions
    var countdowns: [Countdown] = []
    
    init(sceneTransitions: CountdownListSceneTransitions) {
        self.sceneTransitions = sceneTransitions
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
        
        Stylesheet.applyOn(self)
        collectionView?.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: "countdownCell")
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return countdowns.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("countdownCell", forIndexPath: indexPath)
        cell.contentView.backgroundColor = .redColor()
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let countdown = countdowns[indexPath.row]
        sceneTransitions.showCountdown(countdown)
    }
    
    required init?(coder aDecoder: NSCoder) { return nil }
    
}
