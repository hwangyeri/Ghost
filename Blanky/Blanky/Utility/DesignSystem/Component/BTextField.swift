//
//  BTextField.swift
//  Blanky
//
//  Created by Yeri Hwang on 2023/11/18.
//

import UIKit
import TextFieldEffects

final class BTextField: HoshiTextField {
    
    init(keyboardType: UIKeyboardType, returnKeyType: UIReturnKeyType, placeholder: String) {
        super.init(frame: .zero)
        
        self.font = .customFont(.regular, size: .M)
        self.tintColor = .point
        self.autocapitalizationType = .none // 자동 대문자
        self.autocorrectionType = .no // 자동 수정
        self.spellCheckingType = .no // 맞춤법 검사
        self.clearButtonMode = .whileEditing
//        self.clearsOnBeginEditing = true // 편집 시 기존 텍스트필드값 제거
        self.keyboardType = keyboardType
        self.returnKeyType = returnKeyType
        self.borderActiveColor = .lightGray
        self.borderInactiveColor = .gray
        self.placeholderColor = .white
        self.placeholder = placeholder
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

