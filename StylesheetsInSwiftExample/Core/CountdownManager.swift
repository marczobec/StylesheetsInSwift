//
//  CountdownManager.swift
//  StylesheetsInSwiftExample
//
//  Created by Marc Zobec on 2016-05-28.
//  Copyright © 2016 Marc Zobec. All rights reserved.
//

import Foundation

struct CountdownManager {
    
    var allCountdowns: [Countdown] = []
    
    init() {
        allCountdowns = loadCountdowns()
    }
    
    mutating func add(countdown: Countdown) {
        allCountdowns.append(countdown)
        saveCountdowns()
    }
    
    mutating func delete(countdown: Countdown) {
        countdownLoop: for (index, tmpCountdown) in allCountdowns.enumerate() {
            if tmpCountdown == countdown {
                allCountdowns.removeAtIndex(index)
                break countdownLoop
            }
        }
        saveCountdowns()
    }
    
    func loadCountdowns() -> [Countdown] {
        // use static list of countdowns for this example project
        return [
            Countdown(title: "WWDC 2016", date: NSDate())
        ]
    }
    
    func saveCountdowns() {
        // not implemented for this example project
    }
    
}