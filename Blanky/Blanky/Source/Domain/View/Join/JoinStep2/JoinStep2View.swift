//
//  PasswordStepView.swift
//  Blanky
//
//  Created by Yeri Hwang on 2023/11/18.
//

import UIKit
import SnapKit
import Then

class JoinStep2View: BaseView {
    
    let backView = {
        let view = UIView()
        view.backgroundColor = UIColor.bColor200
        view.layer.cornerRadius = 40
        return view
    }()
    
    let mainLabel = BLabel(
        text: "닉네임을 정해주세요.",
        fontWeight: .semiBold,
        fontSize: .XL
    )
    
    let subLabel = BLabel(
        text: "버튼을 누르면 새로운 닉네임을 추천해 드려요!",
        fontWeight: .regular,
        fontSize: .S
    )
    
    let nicknameTextField = BTextField(
        keyboardType: .default,
        returnKeyType: .done,
        placeholder: "12글자 이하, 한글, 숫자만 사용해 주세요."
    ).then {
        $0.text = NicknameDataManager.shared.createRandomNickname()
        $0.clearButtonMode = .unlessEditing
    }
    
    let randomButton = BImageButton(
        imageSize: 16,
        imageName: "arrow.triangle.2.circlepath",
        backgroundColor: .bColor300,
        tintColor: .white,
        cornerRadius: 15
    )
    
    let doneButton = BButton(text: "가입 완료").then {
        $0.isEnabled = true
        $0.backgroundColor = .white
    }

    override func configureHierarchy() {
        self.addSubview(backView)
        
        [mainLabel, subLabel, nicknameTextField, randomButton, doneButton].forEach {
            backView.addSubview($0)
        }
    }
    
    override func configureLayout() {
        backView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).inset(50)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        mainLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(60)
            make.horizontalEdges.equalToSuperview().inset(30)
        }
        
        subLabel.snp.makeConstraints { make in
            make.top.equalTo(mainLabel.snp.bottom).offset(5)
            make.horizontalEdges.equalTo(mainLabel)
        }
        
        nicknameTextField.snp.makeConstraints { make in
            make.top.equalTo(subLabel.snp.bottom).offset(40)
            make.height.equalTo(50)
            make.leading.equalTo(mainLabel)
        }
        
        randomButton.snp.makeConstraints { make in
            make.centerY.equalTo(nicknameTextField).offset(5)
            make.leading.equalTo(nicknameTextField.snp.trailing).offset(20)
            make.trailing.equalToSuperview().inset(25)
            make.height.equalTo(40)
            make.width.equalTo(45)
        }
        
        doneButton.snp.makeConstraints { make in
            make.top.equalTo(nicknameTextField.snp.bottom).offset(50)
            make.height.equalTo(50)
            make.horizontalEdges.equalTo(mainLabel)
        }
    }
    
}
