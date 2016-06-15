//
//  Stylesheet.swift
//  StylesheetsInSwiftExample
//
//  Created by Marc Zobec on 2016-05-28.
//  Copyright © 2016 Marc Zobec. All rights reserved.
//

import UIKit

enum Stylesheet {
    
    enum Contexts {
        
        enum Global {
            static let StatusBarStyle = UIStatusBarStyle.lightContent
            static let BackgroundColor = Colors.DarkGray
        }
        
        enum NavigationController {
            static let BarTintColor = Colors.Black
            static let BarTextColor = Colors.White
            static let BarColor = Colors.LightGray
        }
        
        enum CountdownList {
            static let Title = "Countdowns"
            
            static let LayoutItemSpacing = 16.0
        }
        
        enum CountdownDetail {
            static let EditModeTitle = "Edit Countdown"
            static let CreationModeTitle = "Create Countdown"
            
            static let CellBackgroundColor = Colors.LightGray
            static let CellSeparatorColor = Colors.LightGray
            static let CellTextColor = Colors.LightBlue
            static let DatePickerTextColor = Colors.Blue
        }
        
        enum CountdownView {
            static let BackgroundColor = Global.BackgroundColor
            static let CircleColor = Colors.Blue
            static let ProgressStrokeColor = Colors.LightBlue
            static let TextColor = Colors.White

            static let ProgressStrokeWidth = 3.0
        }
        
        enum CountdownListCell {
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
        static let ScreenWidth = UIScreen.main().bounds.width
        static let ScreenHeight = UIScreen.main().bounds.height
    }
    
    enum Fonts {
        static let Bold = "Avenir-Medium"
        static let Regular = "Avenir-Light"
    }
    
}

