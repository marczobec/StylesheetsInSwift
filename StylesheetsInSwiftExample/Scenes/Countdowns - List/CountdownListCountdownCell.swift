//
//  CountdownListCountdownCell.swift
//  StylesheetsInSwiftExample
//
//  Created by Marc Zobec on 2016-05-28.
//  Copyright © 2016 Marc Zobec. All rights reserved.
//

import UIKit

class CountdownListCountdownCell: UICollectionViewCell {
    
    let titleLabel: UILabel
    let countdownView: CountdownView
    private let contentContainerView: UIView
    private let topLabelContainerView: UIView
    private let bottomCountdownContainerView: UIView
    
    override init(frame: CGRect) {
        contentContainerView = UIView(frame: CGRectZero)
        contentContainerView.translatesAutoresizingMaskIntoConstraints = false
        
        topLabelContainerView = UIView(frame: CGRectZero)
        topLabelContainerView.translatesAutoresizingMaskIntoConstraints = false
        contentContainerView.addSubview(topLabelContainerView)
        
        bottomCountdownContainerView = UIView(frame: CGRectZero)
        bottomCountdownContainerView.translatesAutoresizingMaskIntoConstraints = false
        contentContainerView.addSubview(bottomCountdownContainerView)
        
        titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textAlignment = .Center
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.minimumScaleFactor = 0.5
        topLabelContainerView.addSubview(titleLabel)
        
        countdownView = CountdownView()
        countdownView.translatesAutoresizingMaskIntoConstraints = false
        bottomCountdownContainerView.addSubview(countdownView)
        
        super.init(frame: frame)
        
        contentView.backgroundColor = .lightGrayColor()
        
        contentView.addSubview(contentContainerView)
        
        addConstraints()
    }
    
    func updateCell(withCountdown countdown: Countdown) {
        titleLabel.text = countdown.title
        countdownView.update(withCountdown: countdown)
    }
    
    func addConstraints() {
        guard let titleLabelSuperview = titleLabel.superview, countDownSuperview = countdownView.superview, let topContainerSuperview = topLabelContainerView.superview, let bottomContainerSuperview = bottomCountdownContainerView.superview else { return }
        contentContainerView.centerXAnchor.constraintEqualToAnchor(contentView.centerXAnchor).active = true
        contentContainerView.centerYAnchor.constraintEqualToAnchor(contentView.centerYAnchor).active = true
        contentContainerView.widthAnchor.constraintEqualToAnchor(contentView.widthAnchor).active = true
        contentContainerView.heightAnchor.constraintEqualToAnchor(contentView.heightAnchor).active = true
        
        topLabelContainerView.leadingAnchor.constraintEqualToAnchor(topContainerSuperview.leadingAnchor).active = true
        topLabelContainerView.topAnchor.constraintEqualToAnchor(topContainerSuperview.topAnchor).active = true
        topLabelContainerView.trailingAnchor.constraintEqualToAnchor(topContainerSuperview.trailingAnchor).active = true
        topLabelContainerView.heightAnchor.constraintEqualToConstant(24).active = true
        
        bottomCountdownContainerView.leadingAnchor.constraintEqualToAnchor(bottomContainerSuperview.leadingAnchor).active = true
        bottomCountdownContainerView.bottomAnchor.constraintEqualToAnchor(bottomContainerSuperview.bottomAnchor).active = true
        bottomCountdownContainerView.trailingAnchor.constraintEqualToAnchor(bottomContainerSuperview.trailingAnchor).active = true
        bottomCountdownContainerView.topAnchor.constraintEqualToAnchor(topLabelContainerView.bottomAnchor).active = true
        
        titleLabel.leadingAnchor.constraintEqualToAnchor(titleLabelSuperview.leadingAnchor, constant: 2.0).active = true
        titleLabel.topAnchor.constraintEqualToAnchor(titleLabelSuperview.topAnchor, constant: 2.0).active = true
        titleLabel.trailingAnchor.constraintEqualToAnchor(titleLabelSuperview.trailingAnchor, constant: -2.0).active = true
        titleLabel.bottomAnchor.constraintEqualToAnchor(titleLabelSuperview.bottomAnchor, constant: -2.0).active = true
        
        countdownView.leadingAnchor.constraintEqualToAnchor(countDownSuperview.leadingAnchor, constant: 8.0).active = true
        countdownView.topAnchor.constraintEqualToAnchor(countDownSuperview.topAnchor, constant: 8.0).active = true
        countdownView.trailingAnchor.constraintEqualToAnchor(countDownSuperview.trailingAnchor, constant: -8.0).active = true
        countdownView.bottomAnchor.constraintEqualToAnchor(countDownSuperview.bottomAnchor, constant: -8.0).active = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
    
}
