//
//  AppDelegate.swift
//  StylesheetsInSwiftExample
//
//  Created by Marc Zobec on 2016-05-28.
//  Copyright © 2016 Marc Zobec. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow? = UIWindow(frame: UIScreen.mainScreen().bounds)
    let appCoordinator = { return $0 }(AppCoordinator())
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        window?.rootViewController = appCoordinator.navigationController
        window?.makeKeyAndVisible()
        appCoordinator.start()
        
        return true
    }
    
}