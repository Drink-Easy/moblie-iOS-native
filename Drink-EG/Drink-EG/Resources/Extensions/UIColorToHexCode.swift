//
//  UIColorToHexCode.swift
//  Drink-EG
//
//  Created by 이수현 on 8/11/24.
//

import Foundation
import UIKit

extension UIColor {
    func toHex() -> String? {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        
        if self.getRed(&r, green: &g, blue: &b, alpha: &a) {
            let rgb: Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
            return String(format: "#%06x", rgb)
        }
        return nil
    }
}
