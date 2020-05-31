//
//  UIColor.swift
//  UIWatingViewController
//
//  Created by Cao Phuoc Thanh on 5/16/20.
//  Copyright © 2020 Cao Phuoc Thanh. All rights reserved.
//

import UIKit

// MARK: - Color Builders
internal extension UIColor {

    func alpha(_ value: CGFloat) -> UIColor {
        return withAlphaComponent(value)
    }
    
}

internal extension UIColor {
    /// Constructing color from hex string
    ///
    /// - Parameter hex: A hex string, can either contain # or not
    convenience init(_ string: String) {
        var hex = string.hasPrefix("#")
            ? String(string.dropFirst())
            : string
        guard hex.count == 3 || hex.count == 6
            else {
                self.init(white: 1.0, alpha: 0.0)
                return
        }
        if hex.count == 3 {
            for (index, char) in hex.enumerated() {
                hex.insert(char, at: hex.index(hex.startIndex, offsetBy: index * 2))
            }
        }
        
        self.init(
            red:   CGFloat((Int(hex, radix: 16)! >> 16) & 0xFF) / 255.0,
            green: CGFloat((Int(hex, radix: 16)! >> 8) & 0xFF) / 255.0,
            blue:  CGFloat((Int(hex, radix: 16)!) & 0xFF) / 255.0, alpha: 1.0)
    }
    
    convenience init(_ int: Int) {
        let red     = CGFloat((int & 0xFF0000) >> 16) / 255.0
        let green   = CGFloat((int & 0xFF00) >> 8) / 255.0
        let blue    = CGFloat((int & 0xFF)) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }

}
