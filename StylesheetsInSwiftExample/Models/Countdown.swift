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
    let date: Date
    
    func remainingTime() -> (days: Int, hours: Int, minutes: Int, seconds: Int) {
        let components = Calendar.current().components([Calendar.Unit.day,  Calendar.Unit.hour, Calendar.Unit.minute, Calendar.Unit.second], from: Date(), to: date, options: Calendar.Options.wrapComponents)
        return (days: components.day!, hours: components.hour!, minutes: components.minute!, seconds: components.second!)
    }
    
}

extension Countdown: Equatable {}
func ==(lhs: Countdown, rhs: Countdown) -> Bool {
    return lhs.title == rhs.title && lhs.date == rhs.date
}
