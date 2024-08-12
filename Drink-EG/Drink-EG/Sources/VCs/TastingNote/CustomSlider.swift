//
//  CustomSlider.swift
//  Drink-EG
//
//  Created by 이수현 on 8/11/24.
//

import UIKit

class CustomSlider: UISlider {
    
    override func trackRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.trackRect(forBounds: bounds)
        
        rect.size.height = 11
        
        return rect
    }
}
