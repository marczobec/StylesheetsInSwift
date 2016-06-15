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
    func countdownDetailController(_ countdownDetailController: CountdownDetailController, didEditCountdownAtIndex index: Int, withTitle title: String, date: Date)
    func countdownDetailController(_ countdownDetailController: CountdownDetailController, didAddCountdownWithTitle title: String, date: Date)
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
    
    private let dateFormatter: DateFormatter
    
    init(sceneTransitions: CountdownDetailSceneTransitions, isInEditMode: (bool: Bool, index: Int, countdown: Countdown?) = (false, 0, nil)) {
        self.sceneTransitions = sceneTransitions
        self.isInEditMode = isInEditMode
        
        self.titleCell = UITableViewCell()
        self.titleTextField = UITextField()
        self.titleTextField.translatesAutoresizingMaskIntoConstraints = false
        self.titleTextField.isUserInteractionEnabled = false
        self.titleCell.contentView.addSubview(self.titleTextField)
        
        self.dateLabelCell = UITableViewCell()
        self.dateLabel = UILabel()
        self.dateLabel.translatesAutoresizingMaskIntoConstraints = false
        self.dateLabelCell.contentView.addSubview(self.dateLabel)
        
        self.datePickerCell = UITableViewCell()
        self.datePicker = UIDatePicker()
        self.datePicker.translatesAutoresizingMaskIntoConstraints = false
        self.datePicker.datePickerMode = .dateAndTime
        self.datePicker.minimumDate = Date()
        self.datePickerCell.contentView.addSubview(self.datePicker)
        
        self.isDatePickerToggled = false
        
        self.dateFormatter = DateFormatter()
        self.dateFormatter.dateStyle = .shortStyle
        self.dateFormatter.timeStyle = .mediumStyle
        
        super.init(style: .grouped)
        edgesForExtendedLayout = UIRectEdge()
        Stylesheet.applyOn(self)
        
        titleTextField.delegate = self
        titleTextField.text = isInEditMode.countdown?.title ?? ""
        datePicker.date = isInEditMode.countdown?.date ?? Date()
        dateLabel.text = dateFormatter.string(from: datePicker.date)
        datePicker.addTarget(self, action: #selector(didSelectDate), for: .valueChanged)
        
        addConstraints()
    }

    override func viewWillDisappear(_ animated: Bool) {
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
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : isDatePickerToggled ? 2 : 1
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0: return "Title"
        case 1: return "Date"
        default: return ""
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath as NSIndexPath).section == 0 {
            return titleCell
        } else if (indexPath as NSIndexPath).section == 1 {
            if (indexPath as NSIndexPath).row == 0 {
                return dateLabelCell
            } else if (indexPath as NSIndexPath).row == 1 {
                return datePickerCell
            }
        }
        fatalError("Unknown Cell")
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (indexPath as NSIndexPath).section == 1 && (indexPath as NSIndexPath).row == 1 ? datePicker.frame.height : tableView.rowHeight
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard (indexPath as NSIndexPath).row == 0 else { return }
        
        if (indexPath as NSIndexPath).section == 0 {
            titleTextField.isUserInteractionEnabled = true
            titleTextField.becomeFirstResponder()
            if (isDatePickerToggled) { toggleDatePicker() }
        } else if (indexPath as NSIndexPath).section == 1 {
            titleTextField.isUserInteractionEnabled = false
            titleTextField.resignFirstResponder()
            toggleDatePicker()
        }
    }
    
    func toggleDatePicker() {
        isDatePickerToggled = !isDatePickerToggled
        
        tableView.beginUpdates()
        
        let datePickerIndexPath = IndexPath(row: 1, section: 1)
        if isDatePickerToggled {
            tableView.insertRows(at: [datePickerIndexPath], with: .fade)
        } else {
            tableView.deleteRows(at: [datePickerIndexPath], with: .fade)
        }
        
        tableView.endUpdates()
    }
    
    func didSelectDate(_ datePicker: UIDatePicker) {
        dateLabel.text = dateFormatter.string(from: datePicker.date)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func addConstraints() {
        guard let textfieldSuperview = titleTextField.superview, datelabelSuperview = dateLabel.superview, let datepickerSuperview = datePicker.superview  else { return }
        
        titleTextField.leadingAnchor.constraint(equalTo: textfieldSuperview.leadingAnchor, constant: 16).isActive = true
        titleTextField.topAnchor.constraint(equalTo: textfieldSuperview.topAnchor, constant: 2).isActive = true
        titleTextField.trailingAnchor.constraint(equalTo: textfieldSuperview.trailingAnchor, constant: -16).isActive = true
        titleTextField.bottomAnchor.constraint(equalTo: textfieldSuperview.bottomAnchor, constant: -2).isActive = true
        
        dateLabel.leadingAnchor.constraint(equalTo: datelabelSuperview.leadingAnchor, constant: 16).isActive = true
        dateLabel.topAnchor.constraint(equalTo: datelabelSuperview.topAnchor, constant: 2).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: datelabelSuperview.trailingAnchor, constant: -16).isActive = true
        dateLabel.bottomAnchor.constraint(equalTo: datelabelSuperview.bottomAnchor, constant: -2).isActive = true
        
        datePicker.leadingAnchor.constraint(equalTo: datepickerSuperview.leadingAnchor, constant: 16).isActive = true
        datePicker.topAnchor.constraint(equalTo: datepickerSuperview.topAnchor, constant: 2).isActive = true
        datePicker.trailingAnchor.constraint(equalTo: datepickerSuperview.trailingAnchor, constant: -16).isActive = true
        datePicker.bottomAnchor.constraint(equalTo: datepickerSuperview.bottomAnchor, constant: -2).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) { return nil }
    
}
