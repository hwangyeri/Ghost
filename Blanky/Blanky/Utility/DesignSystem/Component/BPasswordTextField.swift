//
//  BPasswordTextField.swift
//  Blanky
//
//  Created by Yeri Hwang on 2023/11/19.
//

import UIKit
import TextFieldEffects

final class BPasswordTextField: HoshiTextField {
    
    init(keyboardType: UIKeyboardType, returnKeyType: UIReturnKeyType, placeholder: String) {
        super.init(frame: .zero)
        
        self.font = .customFont(.regular, size: .M)
        self.tintColor = .point
        self.autocapitalizationType = .none // 자동 대문자
        self.autocorrectionType = .no // 자동 수정
        self.spellCheckingType = .no // 맞춤법 검사
        self.clearsOnBeginEditing = true // 편집 시 기존 텍스트필드값 제거
        self.keyboardType = keyboardType
        self.returnKeyType = returnKeyType
        self.borderActiveColor = .lightGray
        self.borderInactiveColor = .gray
        self.placeholderColor = .white
        self.placeholder = placeholder
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        self.isSecureTextEntry = true
        
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        button.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        button.setImage(UIImage(systemName: "eye"), for: .selected)
        button.tintColor = .lightGray
        rightView = button
        rightViewMode = .always
        button.addTarget(self, action: #selector(showHidePassword(_:)), for: .touchUpInside)
    }
    
    @objc private func showHidePassword(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        self.isSecureTextEntry = !sender.isSelected
    }
    
}


