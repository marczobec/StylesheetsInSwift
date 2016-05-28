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
    
    private var updateTimer: NSTimer?
    
    init(sceneTransitions: CountdownListSceneTransitions) {
        self.sceneTransitions = sceneTransitions
        super.init(collectionViewLayout: CountdownListFlowLayout())
        
        Stylesheet.applyOn(self)
        collectionView?.registerClass(CountdownListCountdownCell.self, forCellWithReuseIdentifier: "countdownCell")
    }
    
    // this is far away from the best way doing this, but it's okay for this example project
    func updateCountdowns() {
        guard let collectionView = collectionView, let visibleCells = collectionView.visibleCells() as? [CountdownListCountdownCell] else { return }
        for cell in visibleCells {
            if let indexPath = collectionView.indexPathForCell(cell) {
                cell.updateCell(withCountdown: countdowns[indexPath.row])
            }
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        updateTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(updateCountdowns), userInfo: nil, repeats: true)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        updateTimer?.invalidate()
        updateTimer = nil
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return countdowns.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("countdownCell", forIndexPath: indexPath) as! CountdownListCountdownCell
        let countdown = countdowns[indexPath.row]
        cell.updateCell(withCountdown: countdown)
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let countdown = countdowns[indexPath.row]
        sceneTransitions.showCountdown(countdown)
    }
    
    required init?(coder aDecoder: NSCoder) { return nil }
    
}
