//
//  Countdown.swift
//  StylesheetsInSwiftExample
//
//  Created by Marc Zobec on 2016-05-28.
//  Copyright © 2016 Marc Zobec. All rights reserved.
//

import Foundation

struct Countdown {
    
    let title: String
    let date: NSDate
    
    func remainingTime() -> (days: Int, hours: Int, minutes: Int, seconds: Int) {
        let components = NSCalendar.currentCalendar().components([NSCalendarUnit.Day,  NSCalendarUnit.Hour, NSCalendarUnit.Minute, NSCalendarUnit.Second], fromDate: NSDate(), toDate: date, options: NSCalendarOptions.WrapComponents)
        return (days: components.day, hours: components.hour, minutes: components.minute, seconds: components.second)
    }
    
}

extension Countdown: Equatable {}
func ==(lhs: Countdown, rhs: Countdown) -> Bool {
    return lhs.title == rhs.title && lhs.date == rhs.date
}