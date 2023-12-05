//
//  GTextField.swift
//  Blanky
//
//  Created by Yeri Hwang on 2023/12/05.
//

import UIKit

final class GTextField: UITextField {
    
    init(weight: UIFont.CustomFontWeight, size: UIFont.CustomFontSize, returnKeyType: UIReturnKeyType) {
        super.init(frame: .zero)
        
        self.font = .customFont(weight, size: size)
        self.tintColor = .point
        self.autocapitalizationType = .none
        self.autocorrectionType = .no
        self.spellCheckingType = .no
        self.keyboardType = .default
        self.returnKeyType = returnKeyType
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


