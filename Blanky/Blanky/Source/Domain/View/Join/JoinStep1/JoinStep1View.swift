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
    
    let backView = GBackView()
    
    let emailLabel = GLabel(
        text: "이메일을 입력해 주세요.",
        fontWeight: .semiBold,
        fontSize: .XL
    )
    
    let emailTextField = GHoshiTextField(
        keyboardType: .emailAddress,
        returnKeyType: .next,
        placeholder: "영문, 숫자만 사용해 주세요."
    )
    
    let checkEmailDuplicationButton = GButton(
        text: "중복 확인",
        cornerRadius: 16,
        weight: .regular, size: .XXS
    )
    
    let emailInfoLabel = GLabel(
        text: "✅  사용 가능한 이메일인지 확인해 주세요.",
        fontWeight: .regular,
        fontSize: .XXS
    )
    
    let passwordLabel = GLabel(
        text: "비밀번호를 입력해 주세요.",
        fontWeight: .semiBold,
        fontSize: .XL
    )
    
    let passwordTextField = GPasswordTextField(
        keyboardType: .default,
        returnKeyType: .next, 
        placeholder: "8글자 이상, 영문, 숫자, 특수문수 모두 사용해 주세요."
    )
    
    let checkPasswordTextField = GPasswordTextField(
        keyboardType: .default,
        returnKeyType: .next, 
        placeholder: "비밀번호를 확인해 주세요."
    )
    
    let nextButton = GButton(
        text: "다음",
        cornerRadius: 25,
        weight: .semiBold, size: .M)
    
    override func configureHierarchy() {
        self.addSubview(backView)

        [emailLabel, emailTextField, checkEmailDuplicationButton, emailInfoLabel, passwordLabel, passwordTextField, checkPasswordTextField, nextButton].forEach {
            backView.addSubview($0)
        }
    }
    
    override func configureLayout() {
        backView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).inset(30)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        emailLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(50)
            make.horizontalEdges.equalToSuperview().inset(25)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(emailLabel.snp.bottom).offset(20)
            make.height.equalTo(50)
            make.leading.equalTo(emailLabel)
        }
        
        checkEmailDuplicationButton.snp.makeConstraints { make in
            make.centerY.equalTo(emailTextField)
            make.leading.equalTo(emailTextField.snp.trailing).offset(10)
            make.trailing.equalToSuperview().inset(15)
            make.height.equalTo(33)
            make.width.equalTo(65)
        }
        
        emailInfoLabel.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(emailLabel)
        }
        
        passwordLabel.snp.makeConstraints { make in
            make.top.equalTo(emailInfoLabel.snp.bottom).offset(65)
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
