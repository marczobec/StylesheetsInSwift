//
//  Stylesheet.swift
//  StylesheetsInSwiftExample
//
//  Created by Marc Zobec on 2016-05-28.
//  Copyright © 2016 Marc Zobec. All rights reserved.
//

import UIKit

struct Stylesheet {
    
    enum Contexts {
        struct Global {
            static let StatusBarStyle = UIStatusBarStyle.LightContent
            static let BackgroundColor = Colors.DarkGray
        }
        
        struct NavigationController {
            static let BarTintColor = Colors.Black
            static let BarTextColor = Colors.White
            static let BarColor = Colors.LightGray
        }
        
        struct CountdownList {
            static let Title = "Countdowns"
        }
        
        struct CountdownDetail {
            static let EditModeTitle = "Edit Countdown"
            static let CreationModeTitle = "Create Countdown"
            
            static let CellBackgroundColor = Colors.LightGray
            static let CellSeparatorColor = Colors.LightGray
            static let CellTextColor = Colors.LightBlue
            static let DatePickerTextColor = Colors.Blue
        }
        
        struct CountdownView {
            static let BackgroundColor = Global.BackgroundColor
            static let CircleColor = Colors.Blue
            static let ProgressStrokeColor = Colors.LightBlue
            static let TextColor = Colors.White

            static let ProgressStrokeWidth = 3.0
        }
        
        struct CountdownListCell {
            static let BackgroundColor = Colors.Black
            static let TitleTextColor = Colors.Blue
        }
    }
    
    enum Colors {
        static let White = UIColor(hex: "#FFFFFF")
        static let Black = UIColor(hex: "#262626")
        static let DarkGray = UIColor(hex: "#333333")
        static let LightGray = UIColor(hex: "#787878")
        static let Blue = UIColor(hex: "#7AA0CC")
        static let LightBlue = UIColor(hex: "#9AC9FF")
        // Colors borrowed from Tweetbot's dark color scheme
    }
    
    enum Sizes {
        static let ScreenWidth = UIScreen.mainScreen().bounds.width
        static let ScreenHeight = UIScreen.mainScreen().bounds.height
    }
    
    enum Fonts {
        static let Bold = "Avenir-Medium"
        static let Regular = "Avenir-Light"
    }
    
}

