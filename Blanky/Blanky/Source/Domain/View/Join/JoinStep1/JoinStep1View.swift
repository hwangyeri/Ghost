//
//  EmailStepView.swift
//  Blanky
//
//  Created by Yeri Hwang on 2023/11/18.
//

import UIKit
import SnapKit
import Then

class JoinStep1View: BaseView {
    
    let emailLabel = BLabel(
        text: "이메일을 입력해 주세요.",
        fontWeight: .semiBold,
        fontSize: .M
    )
    
    let emailTextField = BTextField(
        keyboardType: .emailAddress,
        returnKeyType: .next,
        placeholder: "영문, 숫자만 사용해 주세요."
    )
    
    let checkEmailDuplicationButton = BButton(text: "중복 확인").then {
        $0.layer.cornerRadius = 16
        $0.titleLabel?.font = .customFont(.regular, size: .XXS)
    }
    
    let emailInfoLabel = BLabel(
        text: "✅  사용 가능한 이메일인지 확인해 주세요.",
        fontWeight: .regular,
        fontSize: .XXS
    )
    
    let passwordLabel = BLabel(
        text: "비밀번호를 입력해 주세요.",
        fontWeight: .semiBold,
        fontSize: .M
    )
    
    let passwordTextField = BPasswordTextField(
        keyboardType: .default,
        returnKeyType: .next, 
        placeholder: "8글자 이상, 영문, 숫자, 특수문수 모두 사용해 주세요."
    )
    
    let checkPasswordTextField = BPasswordTextField(
        keyboardType: .default,
        returnKeyType: .next, 
        placeholder: "비밀번호를 확인해 주세요."
    )
    
    let nextButton = BButton(text: "다음")
    
    override func configureHierarchy() {
        [emailLabel, emailTextField, checkEmailDuplicationButton, emailInfoLabel, passwordLabel, passwordTextField, checkPasswordTextField, nextButton].forEach {
            self.addSubview($0)
        }
    }
    
    override func configureLayout() {
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).inset(50)
            make.horizontalEdges.equalToSuperview().inset(20)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(emailLabel.snp.bottom).offset(20)
            make.height.equalTo(50)
            make.leading.equalTo(emailLabel)
        }
        
        checkEmailDuplicationButton.snp.makeConstraints { make in
            make.centerY.equalTo(emailTextField)
            make.leading.equalTo(emailTextField.snp.trailing).offset(10)
            make.trailing.equalToSuperview().inset(5)
            make.height.equalTo(33)
            make.width.equalTo(65)
        }
        
        emailInfoLabel.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(emailLabel)
        }
        
        passwordLabel.snp.makeConstraints { make in
            make.top.equalTo(emailInfoLabel.snp.bottom).offset(50)
            make.horizontalEdges.equalTo(emailLabel)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordLabel.snp.bottom).offset(20)
            make.height.equalTo(emailTextField)
            make.horizontalEdges.equalTo(emailLabel)
        }
        
        checkPasswordTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(25)
            make.height.equalTo(emailTextField)
            make.horizontalEdges.equalTo(emailLabel)
        }
        
        nextButton.snp.makeConstraints { make in
            make.top.equalTo(checkPasswordTextField.snp.bottom).offset(40)
            make.height.equalTo(50)
            make.horizontalEdges.equalTo(emailLabel)
        }
    }
    
}
