//
//  String.swift
//  Drink-EG
//
//  Created by 김도연 on 8/20/24.
//

import UIKit

extension String {
    var unescapedString: String {
        let mutableString = NSMutableString(string: self)
        CFStringTransform(mutableString, nil, "Any-Hex/Java" as NSString, true)
        return mutableString as String
    }
}
