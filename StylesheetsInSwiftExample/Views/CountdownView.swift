//
//  CountdownView.swift
//  StylesheetsInSwiftExample
//
//  Created by Marc Zobec on 2016-05-28.
//  Copyright © 2016 Marc Zobec. All rights reserved.
//

import UIKit

class CountdownView: UIView {
    
    private let stackView: UIStackView
    
    let circleView: UIView
    let topLabel: UILabel
    let midLabel: UILabel
    let bottomLabel: UILabel
    let progressLayer: CAShapeLayer
    
    var maxValue: CGFloat = 60
    var currentValue: CGFloat = 0 { didSet { animateProgress() } }
    var progress: CGFloat { get { return currentValue / maxValue } }
    
    var createCountdownLabel: (text: String) -> UILabel = { text in
        return UILabel().then {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.text = text
            $0.textAlignment = .Center
            $0.adjustsFontSizeToFitWidth = true
            $0.minimumScaleFactor = 0.1
        }
    }
    
    init() {
        topLabel = createCountdownLabel(text: "0 days")
        midLabel = createCountdownLabel(text: "0 hours")
        bottomLabel = createCountdownLabel(text: "0 minutes")
        
        stackView = UIStackView(arrangedSubviews: [topLabel, midLabel, bottomLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .Vertical
        stackView.distribution = .FillEqually
        
        circleView = UIView(frame: CGRectZero)
        circleView.translatesAutoresizingMaskIntoConstraints = false
        circleView.backgroundColor = .darkGrayColor()
        circleView.addSubview(stackView)
        
        progressLayer = CAShapeLayer()
        
        super.init(frame: CGRectZero)
        
        addSubview(circleView)
        layer.addSublayer(progressLayer)
        
        addConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        circleView.layer.cornerRadius = circleView.bounds.width / 2.0
        resizeProgressLayer()
    }
    
    func resizeProgressLayer() {
        progressLayer.position = CGPointZero
        progressLayer.lineWidth = 3.0
        progressLayer.strokeEnd = currentValue / maxValue
        progressLayer.fillColor = nil
        progressLayer.strokeColor = UIColor.blackColor().CGColor
        
        let radius = CGFloat(circleView.bounds.height/2) - (progressLayer.lineWidth / 2)
        let startAngle = CGFloat(-M_PI / 2)
        let endAngle = CGFloat(3 * M_PI / 2)
        let modelCenter = CGPointMake(bounds.width / 2, bounds.height / 2)
        let path = UIBezierPath(arcCenter: modelCenter, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        
        progressLayer.path = path.CGPath
    }
    
    func animateProgress() {
        let fromValue = progressLayer.strokeEnd
        let toValue = currentValue / maxValue
        
        let strokeAnimation = CABasicAnimation(keyPath: "strokeEnd")
        strokeAnimation.fromValue = fromValue
        strokeAnimation.toValue = toValue
        strokeAnimation.duration = 1
        
        progressLayer.addAnimation(strokeAnimation, forKey: "stroke")
        progressLayer.strokeEnd = toValue
    }
    
    func addConstraints() {
        circleView.centerXAnchor.constraintEqualToAnchor(centerXAnchor).active = true
        circleView.centerYAnchor.constraintEqualToAnchor(centerYAnchor).active = true
        circleView.widthAnchor.constraintEqualToAnchor(circleView.heightAnchor).active = true
        circleView.topAnchor.constraintGreaterThanOrEqualToAnchor(topAnchor, constant: 0).active = true
        circleView.leadingAnchor.constraintEqualToAnchor(leadingAnchor).then { $0.priority = 700 }.active = true
        
        topLabel.setContentCompressionResistancePriority(UILayoutPriorityDefaultLow, forAxis: .Horizontal)
        midLabel.setContentCompressionResistancePriority(UILayoutPriorityDefaultLow, forAxis: .Horizontal)
        bottomLabel.setContentCompressionResistancePriority(UILayoutPriorityDefaultLow, forAxis: .Horizontal)
        
        stackView.centerXAnchor.constraintEqualToAnchor(circleView.centerXAnchor).active = true
        stackView.centerYAnchor.constraintEqualToAnchor(circleView.centerYAnchor).active = true
        stackView.widthAnchor.constraintEqualToAnchor(circleView.widthAnchor, multiplier: 0.675).active = true
        stackView.heightAnchor.constraintEqualToAnchor(stackView.widthAnchor).active = true
    }
    
    required init?(coder aDecoder: NSCoder) { return nil }
    
}