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
    
    static func applyOn(_ navVC: NavigationController) {
        typealias context = Contexts.NavigationController
        navVC.navigationBar.barTintColor = context.BarTintColor
        navVC.navigationBar.tintColor = context.BarColor
        navVC.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: Fonts.Regular, size: 22.0)!, NSForegroundColorAttributeName: context.BarTextColor]
        navVC.navigationBar.isTranslucent = false
    }
    
    static func applyOn(_ listVC: CountdownListController) {
        typealias context = Contexts.CountdownList
        listVC.title = context.Title
        listVC.view.backgroundColor = Contexts.Global.BackgroundColor
        listVC.collectionView?.backgroundColor = Contexts.Global.BackgroundColor
    }
    
    static func applyOn(_ cell: CountdownListCountdownCell) {
        typealias context = Contexts.CountdownListCell
        cell.backgroundColor = context.BackgroundColor
        cell.contentView.backgroundColor = context.BackgroundColor
        cell.titleLabel.textColor = context.TitleTextColor
        
        cell.titleLabel.font = UIFont(name: Fonts.Regular, size: cell.titleLabel.font?.pointSize ?? 0)
    }
    
    static func applyOn(_ countdownView: CountdownView) {
        typealias context = Contexts.CountdownView
        countdownView.circleView.backgroundColor = context.CircleColor
        countdownView.progressLayer.fillColor = nil
        countdownView.progressLayer.strokeColor = context.ProgressStrokeColor.cgColor
        countdownView.progressLayer.lineWidth = CGFloat(context.ProgressStrokeWidth)
        countdownView.topLabel.textColor = context.TextColor
        countdownView.midLabel.textColor = context.TextColor
        countdownView.bottomLabel.textColor = context.TextColor
        
        countdownView.topLabel.font = UIFont(name: Fonts.Bold, size: countdownView.topLabel.font?.pointSize ?? 0)
        countdownView.midLabel.font = UIFont(name: Fonts.Bold, size: countdownView.midLabel.font?.pointSize ?? 0)
        countdownView.bottomLabel.font = UIFont(name: Fonts.Bold, size: countdownView.bottomLabel.font?.pointSize ?? 0)
    }
    
    static func applyOn(_ detailVC: CountdownDetailController) {
        typealias context = Contexts.CountdownDetail
        detailVC.title = detailVC.isInEditMode.bool ? context.EditModeTitle : context.CreationModeTitle
        detailVC.view.backgroundColor = Contexts.Global.BackgroundColor
        detailVC.tableView.backgroundColor = Contexts.Global.BackgroundColor
        detailVC.tableView.separatorColor = context.CellSeparatorColor
        detailVC.titleCell.backgroundColor = context.CellBackgroundColor
        detailVC.titleCell.contentView.backgroundColor = context.CellBackgroundColor
        detailVC.titleCell.selectionStyle = .none
        detailVC.titleTextField.textColor = context.CellTextColor
        detailVC.titleTextField.font = UIFont(name: Fonts.Bold, size: detailVC.titleTextField.font?.pointSize ?? 0)
        detailVC.dateLabelCell.backgroundColor = context.CellBackgroundColor
        detailVC.dateLabelCell.contentView.backgroundColor = context.CellBackgroundColor
        detailVC.dateLabelCell.selectionStyle = .none
        detailVC.dateLabel.textColor = context.CellTextColor
        detailVC.dateLabel.font = UIFont(name: Fonts.Bold, size: detailVC.dateLabel.font?.pointSize ?? 0)
        detailVC.datePickerCell.backgroundColor = context.CellBackgroundColor
        detailVC.datePickerCell.contentView.backgroundColor = context.CellBackgroundColor
        detailVC.datePickerCell.selectionStyle = .none
        detailVC.datePicker.backgroundColor = context.CellBackgroundColor
        detailVC.datePicker.setValue(context.DatePickerTextColor, forKey: "textColor")
    }
    
    static func applyOn(_ layout: CountdownListFlowLayout) {
        let itemSpacing = CGFloat(Contexts.CountdownList.LayoutItemSpacing)
        layout.minimumInteritemSpacing = itemSpacing
        layout.minimumLineSpacing = itemSpacing
        layout.sectionInset = UIEdgeInsetsMake(itemSpacing, itemSpacing, itemSpacing, itemSpacing)
    }
    
}
