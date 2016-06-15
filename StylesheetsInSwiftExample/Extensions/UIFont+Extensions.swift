//
//  UIFont+Extensions.swift
//  StylesheetsInSwiftExample
//
//  Created by Marc Zobec on 2016-05-28.
//  Copyright © 2016 Marc Zobec. All rights reserved.
//

import UIKit

extension UIFont {

    func calculateFontSizeThatFits(size: CGSize, withText text: String) -> CGFloat {
        let testString: NSString = NSString(string: text)
        var minSize: CGFloat = 0.0
        var maxSize: CGFloat = 256.0
        var targetSize: CGFloat = 0.0
        var difference: CGFloat = 0.0
        
        while (minSize <= maxSize) {
            targetSize = minSize + (maxSize - minSize) / 2.0
            let font = self.withSize(targetSize)
            difference = size.height - testString.size(attributes: [NSFontAttributeName : font]).height
            
            if targetSize == minSize || targetSize == maxSize {
                if difference < 0 {
                    return targetSize - 1
                }
                return targetSize
            }
            
            if difference < 0 {
                maxSize = targetSize - 1
            } else if difference > 0 {
                minSize = targetSize + 1
            } else {
                return targetSize
            }
        }
        
        return targetSize
    }
    
}
