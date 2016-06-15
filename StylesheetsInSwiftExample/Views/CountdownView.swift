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
    var currentValue: CGFloat = 0 { willSet { animateProgress(from: currentValue, to: newValue) } }
    var progress: CGFloat { get { return currentValue / maxValue } }
    
    var createCountdownLabel: (text: String) -> UILabel = { text in
        return UILabel().then {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.text = text
            $0.textAlignment = .center
            $0.adjustsFontSizeToFitWidth = true
            $0.minimumScaleFactor = 0.1
        }
    }
    
    init() {
        topLabel = createCountdownLabel(text: "0d")
        midLabel = createCountdownLabel(text: "0h")
        bottomLabel = createCountdownLabel(text: "0m")
        
        stackView = UIStackView(arrangedSubviews: [topLabel, midLabel, bottomLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        
        circleView = UIView(frame: CGRect.zero)
        circleView.translatesAutoresizingMaskIntoConstraints = false
        circleView.addSubview(stackView)
        
        progressLayer = CAShapeLayer()
        
        super.init(frame: CGRect.zero)
        Stylesheet.applyOn(self)
        
        addSubview(circleView)
        layer.addSublayer(progressLayer)
        
        addConstraints()
    }
    
    func update(withCountdown countdown: Countdown) {
        let oldTopText = topLabel.text
        let oldMidText = midLabel.text
        let oldBottomText = bottomLabel.text
        
        let remainingTime = countdown.remainingTime()
        topLabel.text = "\(remainingTime.days)d"
        midLabel.text = "\(remainingTime.hours)h"
        bottomLabel.text = "\(remainingTime.minutes)m"
        currentValue = CGFloat(remainingTime.seconds)
        
        didAnyTextChange: if topLabel.text != oldTopText || midLabel.text != oldMidText || bottomLabel.text != oldBottomText {
            updateFontSizes()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        circleView.layer.cornerRadius = circleView.bounds.width / 2.0
        resizeProgressLayer()
    }
    
    func resizeProgressLayer() {
        progressLayer.position = CGPoint.zero
        progressLayer.strokeEnd = currentValue / maxValue
        
        let radius = CGFloat(circleView.bounds.height/2) - (progressLayer.lineWidth / 2)
        let startAngle = CGFloat(-M_PI / 2)
        let endAngle = CGFloat(3 * M_PI / 2)
        let modelCenter = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
        let path = UIBezierPath(arcCenter: modelCenter, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        
        progressLayer.path = path.cgPath
    }
    
    func animateProgress(from: CGFloat, to: CGFloat) {
        let fromValue = from / maxValue
        let toValue = to / maxValue
        let strokeAnimation = CABasicAnimation(keyPath: "strokeEnd")
        strokeAnimation.fromValue = fromValue
        strokeAnimation.toValue = toValue
        strokeAnimation.duration = 0.1
        
        progressLayer.add(strokeAnimation, forKey: "stroke")
        progressLayer.strokeEnd = toValue
    }
    
    func addConstraints() {
        circleView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        circleView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        circleView.widthAnchor.constraint(equalTo: circleView.heightAnchor).isActive = true
        circleView.topAnchor.constraint(greaterThanOrEqualTo: topAnchor, constant: 0).isActive = true
        circleView.leadingAnchor.constraint(equalTo: leadingAnchor).then { $0.priority = 700 }.isActive = true
        
        topLabel.setContentCompressionResistancePriority(UILayoutPriorityDefaultLow, for: .horizontal)
        midLabel.setContentCompressionResistancePriority(UILayoutPriorityDefaultLow, for: .horizontal)
        bottomLabel.setContentCompressionResistancePriority(UILayoutPriorityDefaultLow, for: .horizontal)
        
        stackView.centerXAnchor.constraint(equalTo: circleView.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: circleView.centerYAnchor).isActive = true
        stackView.widthAnchor.constraint(equalTo: circleView.widthAnchor, multiplier: 0.675).isActive = true
        stackView.heightAnchor.constraint(equalTo: stackView.widthAnchor).isActive = true
    }
    
    func updateFontSizes(inFrameSize size: CGSize? = nil) {
        let frameSize = size ?? topLabel.bounds.size
        guard frameSize.width > 0.0 else { return }
        
        let calcTopFontSize = topLabel.font.calculateFontSizeThatFits(size: frameSize, withText: topLabel.text!)
        let calcMidFontSize = midLabel.font.calculateFontSizeThatFits(size: frameSize, withText: midLabel.text!)
        let calcBottomFontSize = bottomLabel.font.calculateFontSizeThatFits(size: frameSize, withText: bottomLabel.text!)
        let fontSize = min(calcTopFontSize, calcMidFontSize, calcBottomFontSize)
        
        guard fontSize >= 1.0 else { return }
        topLabel.font = topLabel.font.withSize(fontSize)
        midLabel.font = midLabel.font.withSize(fontSize)
        bottomLabel.font = bottomLabel.font.withSize(fontSize)
    }
    
    required init?(coder aDecoder: NSCoder) { return nil }
    
}
