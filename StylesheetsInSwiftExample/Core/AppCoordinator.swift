//
//  AppCoordinator.swift
//  StylesheetsInSwiftExample
//
//  Created by Marc Zobec on 2016-05-28.
//  Copyright © 2016 Marc Zobec. All rights reserved.
//

import UIKit

struct AppCoordinator {
    
    var navigationController: NavigationController
    var countdownManager: CountdownManager
    
    init() {
        self.navigationController = NavigationController()
        self.countdownManager = CountdownManager()
    }
    
    func start() {
        Stylesheet.applyOn(navigationController)
        showCountdownList()
    }
    
    func showCountdownList() {
        let countdownListTransitions = CountdownListSceneTransitions(showEditCountdown: showEditCountdown, showCreateCoutndown: showCreateCountdown)
        let countdownListVC = CountdownListController(countdownManager: countdownManager, sceneTransitions: countdownListTransitions)
        navigationController.pushViewController(countdownListVC, animated: true)
    }
    
    func showEditCountdown(atIndex index: Int) {
        let countdown = countdownManager.allCountdowns[index]
        let countdownDetailVC = CountdownDetailController(sceneTransitions: CountdownDetailSceneTransitions(goBack: goBack), isInEditMode: (true, index, countdown))
        countdownDetailVC.delegate = navigationController.viewControllers.last as? CountdownDetailControllerDelegate
        navigationController.pushViewController(countdownDetailVC, animated: true)
    }
    
    func showCreateCountdown() {
        let countdownDetailVC = CountdownDetailController(sceneTransitions: CountdownDetailSceneTransitions(goBack: goBack))
        countdownDetailVC.delegate = navigationController.viewControllers.last as? CountdownDetailControllerDelegate
        navigationController.pushViewController(countdownDetailVC, animated: true)
    }
    
    func goBack() {
        navigationController.popViewControllerAnimated(true)
    }
    
}