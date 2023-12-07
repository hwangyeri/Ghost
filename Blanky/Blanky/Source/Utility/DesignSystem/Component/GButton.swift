//
//  GButton.swift
//  Blanky
//
//  Created by Yeri Hwang on 2023/11/18.
//

import UIKit

final class GButton: UIButton {
    
    init(text: String, cornerRadius: CGFloat, weight: UIFont.CustomFontWeight, size: UIFont.CustomFontSize) {
        super.init(frame: .zero)
        
        self.setTitle(text, for: .normal)
        self.setTitleColor(.black, for: .normal)
        self.layer.cornerRadius = cornerRadius
        self.titleLabel?.font = .customFont(weight, size: size)
        self.backgroundColor = .gray
        
        // Disable 상태로 버튼 UI 초기화
        self.setTitleColor(.darkGray, for: .disabled)
        self.isEnabled = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

