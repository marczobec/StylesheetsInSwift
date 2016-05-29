//
//  CountdownManager.swift
//  StylesheetsInSwiftExample
//
//  Created by Marc Zobec on 2016-05-28.
//  Copyright © 2016 Marc Zobec. All rights reserved.
//

import Foundation

class CountdownManager {
    
    var allCountdowns: [Countdown] = []
    
    init() {
        allCountdowns = loadCountdowns()
    }
    
    func add(countdown: Countdown) {
        allCountdowns.append(countdown)
        saveCountdowns()
    }
    
    func update(atIndex index: Int, withTitle title: String, date: NSDate) {
        allCountdowns[index] = Countdown(title: title, date: date)
    }
    
    func delete(countdown: Countdown) {
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
            Countdown(title: "WWDC 2016", date: NSDate(timeIntervalSince1970: 1465837200)),
            Countdown(title: "Christmas", date: NSDate(timeIntervalSince1970: 1482534000)),
            Countdown(title: "Birthday", date: NSDate(timeIntervalSince1970: 1483484400))
        ]
    }
    
    func saveCountdowns() {
        // not implemented for this example project
    }
    
}