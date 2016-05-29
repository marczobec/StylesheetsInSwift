//
//  Stylesheet+applyOn.swift
//  StylesheetsInSwiftExample
//
//  Created by Marc Zobec on 2016-05-28.
//  Copyright © 2016 Marc Zobec. All rights reserved.
//

import UIKit

typealias Contexts = Stylesheet.Contexts
typealias Colors = Stylesheet.Colors
typealias Sizes = Stylesheet.Sizes
typealias Fonts = Stylesheet.Fonts

extension Stylesheet {
    
    static func applyOn(navVC: NavigationController) {
        typealias context = Contexts.NavigationController
        navVC.navigationBar.barTintColor = context.BarTintColor
        navVC.navigationBar.tintColor = context.BarColor
        navVC.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: context.BarTextColor]
        navVC.navigationBar.translucent = false
    }
    
    static func applyOn(listVC: CountdownListController) {
        typealias context = Contexts.CountdownList
        listVC.title = context.Title
        listVC.view.backgroundColor = Contexts.Global.BackgroundColor
        listVC.collectionView?.backgroundColor = Contexts.Global.BackgroundColor
    }
    
    static func applyOn(cell: CountdownListCountdownCell) {
        typealias context = Contexts.CountdownListCell
        cell.backgroundColor = context.BackgroundColor
        cell.contentView.backgroundColor = context.BackgroundColor
        cell.titleLabel.textColor = context.TitleTextColor
    }
    
    static func applyOn(countdownView: CountdownView) {
        typealias context = Contexts.CountdownView
        countdownView.circleView.backgroundColor = context.CircleColor
        countdownView.progressLayer.fillColor = nil
        countdownView.progressLayer.strokeColor = context.ProgressStrokeColor.CGColor
        countdownView.progressLayer.lineWidth = CGFloat(context.ProgressStrokeWidth)
        countdownView.topLabel.textColor = context.TextColor
        countdownView.midLabel.textColor = context.TextColor
        countdownView.bottomLabel.textColor = context.TextColor
    }
    
    static func applyOn(detailVC: CountdownDetailController) {
        typealias context = Contexts.CountdownDetail
        detailVC.title = detailVC.isInEditMode.bool ? context.EditModeTitle : context.CreationModeTitle
        detailVC.view.backgroundColor = Contexts.Global.BackgroundColor
        detailVC.tableView.backgroundColor = Contexts.Global.BackgroundColor
        detailVC.tableView.separatorColor = context.CellSeparatorColor
        detailVC.titleCell.backgroundColor = context.CellBackgroundColor
        detailVC.titleCell.contentView.backgroundColor = context.CellBackgroundColor
        detailVC.titleCell.selectionStyle = .None
        detailVC.titleTextField.textColor = context.CellTextColor
        detailVC.dateLabelCell.backgroundColor = context.CellBackgroundColor
        detailVC.dateLabelCell.contentView.backgroundColor = context.CellBackgroundColor
        detailVC.dateLabelCell.selectionStyle = .None
        detailVC.dateLabel.textColor = context.CellTextColor
        detailVC.datePickerCell.backgroundColor = context.CellBackgroundColor
        detailVC.datePickerCell.contentView.backgroundColor = context.CellBackgroundColor
        detailVC.datePickerCell.selectionStyle = .None
        detailVC.datePicker.backgroundColor = context.CellBackgroundColor
        detailVC.datePicker.setValue(context.DatePickerTextColor, forKey: "textColor")
    }
    
}
