//
//  Color.swift
//  ToDoLearn4
//
//  Created by bain on 15-6-7.
//  Copyright (c) 2015年 bain. All rights reserved.
//

import UIKit


extension UIColor {
    convenience init(hex: Int, alpha: CGFloat = 1.0) {
        let red = CGFloat((hex & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((hex & 0xFF00) >> 8) / 255.0
        let blue = CGFloat((hex & 0xFF)) / 255.0
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
    
    struct ColorPalette {
        static let xECEFF1 = UIColor(hex: 0xECEFF1)
        static let xCCCFC1 = UIColor(hex: 0xCCCFC1)
    }
    
}