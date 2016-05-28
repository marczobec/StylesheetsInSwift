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
    
}

extension Countdown: Equatable {}
func ==(lhs: Countdown, rhs: Countdown) -> Bool {
    return lhs.title == rhs.title && lhs.date == rhs.date
}