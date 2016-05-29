//
//  CountdownDetailController.swift
//  StylesheetsInSwiftExample
//
//  Created by Marc Zobec on 2016-05-28.
//  Copyright © 2016 Marc Zobec. All rights reserved.
//

import UIKit

struct CountdownDetailSceneTransitions {
    let goBack: (Void) -> Void
}

protocol CountdownDetailControllerDelegate {
    func countdownDetailController(countdownDetailController: CountdownDetailController, didEditCountdownAtIndex index: Int, withTitle title: String, date: NSDate)
    func countdownDetailController(countdownDetailController: CountdownDetailController, didAddCountdownWithTitle title: String, date: NSDate)
}

class CountdownDetailController: UITableViewController, UITextFieldDelegate {
    
    let sceneTransitions: CountdownDetailSceneTransitions
    
    let titleCell: UITableViewCell
    let titleTextField: UITextField
    
    let dateLabelCell: UITableViewCell
    let dateLabel: UILabel
    
    let datePickerCell: UITableViewCell
    let datePicker: UIDatePicker
    
    var isDatePickerToggled: Bool
    
    var delegate: CountdownDetailControllerDelegate?
    var isInEditMode: (bool: Bool, index: Int, countdown: Countdown?)
    
    private let dateFormatter: NSDateFormatter
    
    init(sceneTransitions: CountdownDetailSceneTransitions, isInEditMode: (bool: Bool, index: Int, countdown: Countdown?) = (false, 0, nil)) {
        self.sceneTransitions = sceneTransitions
        self.isInEditMode = isInEditMode
        
        self.titleCell = UITableViewCell()
        self.titleTextField = UITextField()
        self.titleTextField.translatesAutoresizingMaskIntoConstraints = false
        self.titleTextField.userInteractionEnabled = false
        self.titleCell.contentView.addSubview(self.titleTextField)
        
        self.dateLabelCell = UITableViewCell()
        self.dateLabel = UILabel()
        self.dateLabel.translatesAutoresizingMaskIntoConstraints = false
        self.dateLabelCell.contentView.addSubview(self.dateLabel)
        
        self.datePickerCell = UITableViewCell()
        self.datePicker = UIDatePicker()
        self.datePicker.translatesAutoresizingMaskIntoConstraints = false
        self.datePicker.datePickerMode = .DateAndTime
        self.datePicker.minimumDate = NSDate()
        self.datePickerCell.contentView.addSubview(self.datePicker)
        
        self.isDatePickerToggled = false
        
        self.dateFormatter = NSDateFormatter()
        self.dateFormatter.dateStyle = .ShortStyle
        self.dateFormatter.timeStyle = .MediumStyle
        
        super.init(style: .Grouped)
        edgesForExtendedLayout = UIRectEdge.None
        Stylesheet.applyOn(self)
        
        titleTextField.delegate = self
        titleTextField.text = isInEditMode.countdown?.title ?? ""
        datePicker.date = isInEditMode.countdown?.date ?? NSDate()
        dateLabel.text = dateFormatter.stringFromDate(datePicker.date)
        datePicker.addTarget(self, action: #selector(didSelectDate), forControlEvents: .ValueChanged)
        
        addConstraints()
    }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        let title = titleTextField.text ?? ""
        let date = datePicker.date
        if isInEditMode.bool {
            delegate?.countdownDetailController(self, didEditCountdownAtIndex: isInEditMode.index, withTitle: title, date: date)
        } else {
            if !title.isEmpty {
                delegate?.countdownDetailController(self, didAddCountdownWithTitle: title, date: date)
            }
        }
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : isDatePickerToggled ? 2 : 1
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0: return "Title"
        case 1: return "Date"
        default: return ""
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            return titleCell
        } else if indexPath.section == 1 {
            if indexPath.row == 0 {
                return dateLabelCell
            } else if indexPath.row == 1 {
                return datePickerCell
            }
        }
        fatalError("Unknown Cell")
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return indexPath.section == 1 && indexPath.row == 1 ? CGRectGetHeight(datePicker.frame) : tableView.rowHeight
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        guard indexPath.row == 0 else { return }
        
        if indexPath.section == 0 {
            titleTextField.userInteractionEnabled = true
            titleTextField.becomeFirstResponder()
            if (isDatePickerToggled) { toggleDatePicker() }
        } else if indexPath.section == 1 {
            titleTextField.userInteractionEnabled = false
            titleTextField.resignFirstResponder()
            toggleDatePicker()
        }
    }
    
    func toggleDatePicker() {
        isDatePickerToggled = !isDatePickerToggled
        
        tableView.beginUpdates()
        
        let datePickerIndexPath = NSIndexPath(forRow: 1, inSection: 1)
        if isDatePickerToggled {
            tableView.insertRowsAtIndexPaths([datePickerIndexPath], withRowAnimation: .Fade)
        } else {
            tableView.deleteRowsAtIndexPaths([datePickerIndexPath], withRowAnimation: .Fade)
        }
        
        tableView.endUpdates()
    }
    
    func didSelectDate(datePicker: UIDatePicker) {
        dateLabel.text = dateFormatter.stringFromDate(datePicker.date)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func addConstraints() {
        guard let textfieldSuperview = titleTextField.superview, datelabelSuperview = dateLabel.superview, let datepickerSuperview = datePicker.superview  else { return }
        
        titleTextField.leadingAnchor.constraintEqualToAnchor(textfieldSuperview.leadingAnchor, constant: 16).active = true
        titleTextField.topAnchor.constraintEqualToAnchor(textfieldSuperview.topAnchor, constant: 2).active = true
        titleTextField.trailingAnchor.constraintEqualToAnchor(textfieldSuperview.trailingAnchor, constant: -16).active = true
        titleTextField.bottomAnchor.constraintEqualToAnchor(textfieldSuperview.bottomAnchor, constant: -2).active = true
        
        dateLabel.leadingAnchor.constraintEqualToAnchor(datelabelSuperview.leadingAnchor, constant: 16).active = true
        dateLabel.topAnchor.constraintEqualToAnchor(datelabelSuperview.topAnchor, constant: 2).active = true
        dateLabel.trailingAnchor.constraintEqualToAnchor(datelabelSuperview.trailingAnchor, constant: -16).active = true
        dateLabel.bottomAnchor.constraintEqualToAnchor(datelabelSuperview.bottomAnchor, constant: -2).active = true
        
        datePicker.leadingAnchor.constraintEqualToAnchor(datepickerSuperview.leadingAnchor, constant: 16).active = true
        datePicker.topAnchor.constraintEqualToAnchor(datepickerSuperview.topAnchor, constant: 2).active = true
        datePicker.trailingAnchor.constraintEqualToAnchor(datepickerSuperview.trailingAnchor, constant: -16).active = true
        datePicker.bottomAnchor.constraintEqualToAnchor(datepickerSuperview.bottomAnchor, constant: -2).active = true
    }
    
    required init?(coder aDecoder: NSCoder) { return nil }
    
}
