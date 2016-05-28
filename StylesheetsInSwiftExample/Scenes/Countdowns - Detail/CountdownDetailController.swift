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
    
    init(countdown: Countdown, sceneTransitions: CountdownDetailSceneTransitions) {
        self.countdown = countdown
        self.sceneTransitions = sceneTransitions
        super.init(nibName: nil, bundle: nil)
        Stylesheet.applyOn(self)
    }
    
    required init?(coder aDecoder: NSCoder) { return nil }
    
}
