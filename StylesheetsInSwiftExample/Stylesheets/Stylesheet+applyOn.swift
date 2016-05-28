//
//  Stylesheet+applyOn.swift
//  StylesheetsInSwiftExample
//
//  Created by Marc Zobec on 2016-05-28.
//  Copyright © 2016 Marc Zobec. All rights reserved.
//

typealias Contexts = Stylesheet.Contexts
typealias Colors = Stylesheet.Colors
typealias Sizes = Stylesheet.Sizes
typealias Fonts = Stylesheet.Fonts

extension Stylesheet {
    
    static func applyOn(listVC: CountdownListController) {
        listVC.title = Contexts.CountdownList.Title
    }
    
    static func applyOn(detailVC: CountdownDetailController) {
        detailVC.title = detailVC.countdown.title
    }
    
}
