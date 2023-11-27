//
//  LoginView.swift
//  Blanky
//
//  Created by Yeri Hwang on 2023/11/17.
//

import UIKit
import SnapKit
import Then

class LoginView: BaseView {
    
    let mainLabel = UILabel().then {
        $0.text = "Ghost"
        $0.font = .dangamFont(size: 40)
    }
    
    let subLabel = GLabel(
        text: "FIXME: 완전한 익명, 자유로운 유령 (슬로건)",
        fontWeight: .bold,
        fontSize: .M
    )
    
    let emailTextField = GTextField(
        keyboardType: .emailAddress,
        returnKeyType: .next,
        placeholder: "이메일 주소"
    )
    
    let passwordTextField = GPasswordTextField(
        keyboardType: .default,
        returnKeyType: .done,
        placeholder: "비밀번호"
    )
    
    let loginButton = GButton(text: "로그인")
    
    let findEmailButton = GTextButton(text: "이메일 찾기")
    
    let findPasswordButton = GTextButton(text: "비밀번호 찾기")
    
    let joinButton = GTextButton(text: "회원가입")
    
    let stack1Divider = GDivider()
    
    let stack2Divider = GDivider()
    
    override func configureHierarchy() {
        [mainLabel, subLabel, emailTextField, passwordTextField, loginButton, 
         findPasswordButton, stack1Divider, stack2Divider, findEmailButton, joinButton].forEach {
            self.addSubview($0)
        }
    }
    
    override func configureLayout() {
        mainLabel.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).inset(30)
            make.centerX.equalToSuperview()
        }
        
        subLabel.snp.makeConstraints { make in
            make.top.equalTo(mainLabel.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
        
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(subLabel.snp.bottom).offset(60)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(emailTextField)
            make.height.equalTo(emailTextField)
        }
        
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(40)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
        
        findPasswordButton.snp.makeConstraints { make in
            make.top.equalTo(loginButton.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        
        stack1Divider.snp.makeConstraints { make in
            make.trailing.equalTo(findPasswordButton.snp.leading).offset(-22)
            make.verticalEdges.equalTo(findPasswordButton).inset(6)
            make.width.equalTo(2)
        }
        
        stack2Divider.snp.makeConstraints { make in
            make.leading.equalTo(findPasswordButton.snp.trailing).offset(22)
            make.verticalEdges.width.equalTo(stack1Divider)
        }
        
        findEmailButton.snp.makeConstraints { make in
            make.top.equalTo(findPasswordButton)
            make.trailing.equalTo(stack1Divider.snp.leading).inset(-22)
        }
        
        joinButton.snp.makeConstraints { make in
            make.top.equalTo(findPasswordButton)
            make.leading.equalTo(stack2Divider.snp.trailing).offset(22)
        }
    }
    
}
