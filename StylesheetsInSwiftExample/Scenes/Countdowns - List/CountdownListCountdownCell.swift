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
        contentContainerView = UIView(frame: CGRect.zero)
        contentContainerView.translatesAutoresizingMaskIntoConstraints = false
        
        topLabelContainerView = UIView(frame: CGRect.zero)
        topLabelContainerView.translatesAutoresizingMaskIntoConstraints = false
        contentContainerView.addSubview(topLabelContainerView)
        
        bottomCountdownContainerView = UIView(frame: CGRect.zero)
        bottomCountdownContainerView.translatesAutoresizingMaskIntoConstraints = false
        contentContainerView.addSubview(bottomCountdownContainerView)
        
        titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textAlignment = .center
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.minimumScaleFactor = 0.5
        topLabelContainerView.addSubview(titleLabel)
        
        countdownView = CountdownView()
        countdownView.translatesAutoresizingMaskIntoConstraints = false
        bottomCountdownContainerView.addSubview(countdownView)
        
        super.init(frame: frame)
        Stylesheet.applyOn(self)
        
        contentView.addSubview(contentContainerView)
        
        addConstraints()
    }
    
    func updateCell(withCountdown countdown: Countdown) {
        titleLabel.text = countdown.title
        countdownView.update(withCountdown: countdown)
    }
    
    func addConstraints() {
        guard let titleLabelSuperview = titleLabel.superview, countDownSuperview = countdownView.superview, let topContainerSuperview = topLabelContainerView.superview, let bottomContainerSuperview = bottomCountdownContainerView.superview else { return }
        contentContainerView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        contentContainerView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        contentContainerView.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        contentContainerView.heightAnchor.constraint(equalTo: contentView.heightAnchor).isActive = true
        
        topLabelContainerView.leadingAnchor.constraint(equalTo: topContainerSuperview.leadingAnchor).isActive = true
        topLabelContainerView.topAnchor.constraint(equalTo: topContainerSuperview.topAnchor).isActive = true
        topLabelContainerView.trailingAnchor.constraint(equalTo: topContainerSuperview.trailingAnchor).isActive = true
        topLabelContainerView.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        bottomCountdownContainerView.leadingAnchor.constraint(equalTo: bottomContainerSuperview.leadingAnchor).isActive = true
        bottomCountdownContainerView.bottomAnchor.constraint(equalTo: bottomContainerSuperview.bottomAnchor).isActive = true
        bottomCountdownContainerView.trailingAnchor.constraint(equalTo: bottomContainerSuperview.trailingAnchor).isActive = true
        bottomCountdownContainerView.topAnchor.constraint(equalTo: topLabelContainerView.bottomAnchor).isActive = true
        
        titleLabel.leadingAnchor.constraint(equalTo: titleLabelSuperview.leadingAnchor, constant: 2.0).isActive = true
        titleLabel.topAnchor.constraint(equalTo: titleLabelSuperview.topAnchor, constant: 2.0).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: titleLabelSuperview.trailingAnchor, constant: -2.0).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: titleLabelSuperview.bottomAnchor, constant: -2.0).isActive = true
        
        countdownView.leadingAnchor.constraint(equalTo: countDownSuperview.leadingAnchor, constant: 8.0).isActive = true
        countdownView.topAnchor.constraint(equalTo: countDownSuperview.topAnchor, constant: 8.0).isActive = true
        countdownView.trailingAnchor.constraint(equalTo: countDownSuperview.trailingAnchor, constant: -8.0).isActive = true
        countdownView.bottomAnchor.constraint(equalTo: countDownSuperview.bottomAnchor, constant: -8.0).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
    
}
