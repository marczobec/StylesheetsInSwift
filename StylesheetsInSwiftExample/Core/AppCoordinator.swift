//
//  AppCoordinator.swift
//  StylesheetsInSwiftExample
//
//  Created by Marc Zobec on 2016-05-28.
//  Copyright © 2016 Marc Zobec. All rights reserved.
//

import UIKit

struct AppCoordinator {
    
    var navigationController: UINavigationController
    let countdownManager: CountdownManager
    
    init() {
        self.navigationController = UINavigationController()
        self.countdownManager = CountdownManager()
    }
    
    func start() {
        showCountdownList()
    }
    
    func showCountdownList() {
        let countdownListTransitions = CountdownListSceneTransitions(showCountdown: showCountdown)
        let countdownListVC = CountdownListController(sceneTransitions: countdownListTransitions)
        countdownListVC.countdowns = countdownManager.allCountdowns
        navigationController.pushViewController(countdownListVC, animated: true)
    }
    
    func showCountdown(countdown: Countdown) {
        let countdownDetailVC = CountdownDetailController(countdown: countdown, sceneTransitions: CountdownDetailSceneTransitions(goBack: goBack))
        navigationController.pushViewController(countdownDetailVC, animated: true)
    }
    
    func goBack() {
        navigationController.popViewControllerAnimated(true)
    }
    
}
