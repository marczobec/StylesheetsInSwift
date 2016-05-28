//
//  CountdownDetailController.swift
//  StylesheetsInSwiftExample
//
//  Created by Marc Zobec on 2016-05-28.
//  Copyright © 2016 Marc Zobec. All rights reserved.
//

import UIKit

struct CountdownDetailSceneTransitions {
    let goBack: (Void) -> Void
}

class CountdownDetailController: UIViewController {
    
    let sceneTransitions: CountdownDetailSceneTransitions
    let countdown: Countdown
    
    var countdownView: CountdownView {
        return view as! CountdownView
    }
    
    private var updateTimer: NSTimer?
    
    init(countdown: Countdown, sceneTransitions: CountdownDetailSceneTransitions) {
        self.countdown = countdown
        self.sceneTransitions = sceneTransitions
        super.init(nibName: nil, bundle: nil)
        Stylesheet.applyOn(self)
        
        self.edgesForExtendedLayout = UIRectEdge.None
    }
    
    override func loadView() {
        let countdownView = CountdownView()
        view = countdownView
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        updateCountdownView()
        updateTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(updateCountdownView), userInfo: nil, repeats: true)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        updateTimer?.invalidate()
        updateTimer = nil
    }
    
    func updateCountdownView() {
        countdownView.update(withCountdown: countdown)
    }
    
    required init?(coder aDecoder: NSCoder) { return nil }
    
}
