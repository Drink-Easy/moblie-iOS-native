//
//  UIColor+Extensions.swift
//  Drink-EG
//
//  Created by 김도연 on 10/9/24.
//

import UIKit

struct AppColor {
    static let wineClassPurple = "#7E13B1"
}

extension UIColor {
    class func appPurple() -> UIColor {
        return UIColor(hex: AppColor.wineClassPurple)!
    }
}
