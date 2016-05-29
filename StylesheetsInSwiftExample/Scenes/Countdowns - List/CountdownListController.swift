//
//  CountdownListController.swift
//  StylesheetsInSwiftExample
//
//  Created by Marc Zobec on 2016-05-28.
//  Copyright © 2016 Marc Zobec. All rights reserved.
//

import UIKit

struct CountdownListSceneTransitions {
    let showEditCountdown: (index: Int) -> Void
    let showCreateCoutndown: (Void) -> Void
}

class CountdownListController: UICollectionViewController {
    
    let sceneTransitions: CountdownListSceneTransitions
    
    var countdownManager: CountdownManager
    var countdowns: [Countdown] { return countdownManager.allCountdowns }
    
    private var updateTimer: NSTimer?
    private let flowLayout = CountdownListFlowLayout()
    
    init(countdownManager: CountdownManager, sceneTransitions: CountdownListSceneTransitions) {
        self.countdownManager = countdownManager
        self.sceneTransitions = sceneTransitions
        super.init(collectionViewLayout: flowLayout)
        
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
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(didSelectAddCountdownBarButtonItem))
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
        sceneTransitions.showEditCountdown(index: indexPath.row)
    }
    
    func didSelectAddCountdownBarButtonItem(barButtonItem: UIBarButtonItem) {
        sceneTransitions.showCreateCoutndown()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        guard let collectionView = collectionView, let visibleCells = collectionView.visibleCells() as? [CountdownListCountdownCell] else { return }
        for cell in visibleCells {
            let itemSize = cell.countdownView.circleView.frame.size
            let approxWidth = itemSize.width * 0.675
            cell.countdownView.updateFontSizes(inFrameSize: CGSize(width: approxWidth, height: approxWidth / 3))
        }
    }
    
    required init?(coder aDecoder: NSCoder) { return nil }
    
}

extension CountdownListController: CountdownDetailControllerDelegate {
    
    func countdownDetailController(countdownDetailController: CountdownDetailController, didAddCountdownWithTitle title: String, date: NSDate) {
        countdownManager.add(Countdown(title: title, date: date))
        collectionView?.reloadData()
    }
    
    func countdownDetailController(countdownDetailController: CountdownDetailController, didEditCountdownAtIndex index: Int, withTitle title: String, date: NSDate) {
        countdownManager.update(atIndex: index, withTitle: title, date: date)
        collectionView?.reloadData()
    }
    
}
