//
//  NavigationController.swift
//  StylesheetsInSwiftExample
//
//  Created by Marc Zobec on 2016-05-28.
//  Copyright © 2016 Marc Zobec. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
        Stylesheet.applyOn(self)
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return Stylesheet.Contexts.Global.StatusBarStyle
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
}
