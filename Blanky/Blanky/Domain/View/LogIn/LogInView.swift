//
//  LogInView.swift
//  Blanky
//
//  Created by Yeri Hwang on 2023/11/17.
//

import UIKit
import SnapKit

class LogInView: BaseView {
    
    let mainLabel = {
        let view = BLabel(
            text: "Blanky",
            fontWeight: .black,
            fontSize: .XXXL
        )
        return view
    }()
    
    let subLabel = {
        let view = BLabel(
            text: "ImageView로 수정",
            fontWeight: .bold,
            fontSize: .L
        )
        return view
    }()
    
    let emailTitleLabel = {
        let view = BLabel(
            text: "이메일 주소",
            fontWeight: .semiBold,
            fontSize: .XS
        )
        return view
    }()
    
    let emailTextField = {
        let view = BTextField(
            keyboardType: .emailAddress, 
            returnKeyType: .next
        )
        view.placeholder = "예) blanky@blanky.com"
        return view
    }()
    
    let emailDivider = {
        let view = BDivider()
        return view
    }()
    
    let passwordTitleLabel = {
        let view = BLabel(
            text: "비밀번호",
            fontWeight: .semiBold,
            fontSize: .XS
        )
        return view
    }()
    
    let passwordTextField = {
        let view = BTextField(
            keyboardType: .default, 
            returnKeyType: .done
        )
        return view
    }()
    
    let passwordDivider = {
        let view = BDivider()
        return view
    }()
    
    let logInButton = {
        let view = BButton(
            text: "로그인",
            titleColor: .black,
            cornerRadius: 10,
            backgroundColor: .gray
        )
        // Disable 상태로 버튼 UI 초기화
        view.setTitleColor(.darkGray, for: .disabled)
        view.isEnabled = false
        return view
    }()
    
    let findEmailButton = {
        let view = BTextButton(
            text: "이메일 찾기"
        )
        return view
    }()
    
    let findPasswordButton = {
        let view = BTextButton(
            text: "비밀번호 찾기"
        )
        return view
    }()
    
    let joinButton = {
        let view = BTextButton(
            text: "회원가입"
        )
        return view
    }()
    
    let stack1Divider = {
        let view = BDivider()
        return view
    }()
    
    let stack2Divider = {
        let view = BDivider()
        return view
    }()
    
    override func configureHierarchy() {
        [mainLabel, subLabel, emailTitleLabel, emailTextField, emailDivider, passwordTitleLabel, passwordTextField, passwordDivider, logInButton, findPasswordButton, stack1Divider, stack2Divider, findEmailButton, joinButton].forEach {
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
        
        emailTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(subLabel.snp.bottom).offset(60)
            make.horizontalEdges.equalToSuperview().inset(20)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTitleLabel.snp.bottom)
            make.horizontalEdges.equalTo(emailTitleLabel)
            make.height.equalTo(50)
        }
        
        emailDivider.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom)
            make.horizontalEdges.equalTo(emailTitleLabel)
            make.height.equalTo(1)
        }
        
        passwordTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(emailDivider.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(emailTitleLabel)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordTitleLabel.snp.bottom)
            make.horizontalEdges.equalTo(emailTitleLabel)
            make.height.equalTo(emailTextField)
        }
        
        passwordDivider.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom)
            make.horizontalEdges.equalTo(emailTitleLabel)
            make.height.equalTo(emailDivider)
        }
        
        logInButton.snp.makeConstraints { make in
            make.top.equalTo(passwordDivider.snp.bottom).offset(40)
            make.horizontalEdges.equalTo(emailTitleLabel)
            make.height.equalTo(55)
        }
        
        findPasswordButton.snp.makeConstraints { make in
            make.top.equalTo(logInButton.snp.bottom).offset(20)
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
