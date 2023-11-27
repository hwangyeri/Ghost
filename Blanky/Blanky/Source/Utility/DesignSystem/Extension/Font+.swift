//
//  Font+.swift
//  Blanky
//
//  Created by Yeri Hwang on 2023/11/17.
//

import UIKit

extension UIFont {
    
    enum CustomFontWeight: String {
        case black = "Black"
        case bold = "Bold"
        case light = "Light"
        case medium = "Medium"
        case regular = "Regular"
        case semiBold = "SemiBold"
        case thin = "Thin"
    }
    
    enum CustomFontSize: CGFloat {
        case XXS = 12
        case XS = 13
        case S = 14
        case M = 15
        case L = 16
        case XL = 18
        case XXL = 20
        case XXXL = 24
    }
    
    static func customFont(_ weight: CustomFontWeight, size: CustomFontSize) -> UIFont? {
        let fontName = "Pretendard-\(weight.rawValue)"
        return UIFont(name: fontName, size: size.rawValue)
    }
    
    static func dangamFont(size: CGFloat) -> UIFont? {
        let fontName = "CWDangamAsac-Bold"
        return UIFont(name: fontName, size: size)
    }
    
}

