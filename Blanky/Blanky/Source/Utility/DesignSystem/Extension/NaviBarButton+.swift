//
//  NaviBarButton+.swift
//  Blanky
//
//  Created by Yeri Hwang on 2023/11/26.
//

import UIKit
import SnapKit
import Then

extension UIViewController {
    
    //MARK: 배경 있는 왼쪽 네비바 버튼, Back Button <
    func setCustomBackButton() {
        let backButton = GImageButton(imageSize: 18, imageName: "chevron.backward", backgroundColor: .bColor200, tintColor: .white, cornerRadius: 15)
        
        backButton.addTarget(self, action: #selector(customBackButtonTapped), for: .touchUpInside)
        
        backButton.snp.makeConstraints { make in
            make.size.equalTo(42)
        }
        
        
        let customBackButton = UIBarButtonItem(customView: backButton)
        
        self.navigationItem.leftBarButtonItem = customBackButton
    }
    
    //이전 뷰로 화면 전환
    @objc func customBackButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: 오른쪽 네비바 버튼, X Button
    func setCustomExitButton() {
        let exitButton = GImageButton(imageSize: 16, imageName: "xmark", backgroundColor: .bColor200, tintColor: .white, cornerRadius: 15)
        
        exitButton.addTarget(self, action: #selector(exitButtonTapped), for: .touchUpInside)
        
        exitButton.snp.makeConstraints { make in
            make.size.equalTo(42)
        }
        
        let customExitButton = UIBarButtonItem(customView: exitButton)
        
        self.navigationItem.rightBarButtonItem = customExitButton
    }
    
    
    //루트뷰로 화면 전환
    @objc func exitButtonTapped() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    //MARK: 왼쪽 네비바 버튼, X Button
    func setCustomXButton() {
        let xButton = GImageButton(imageSize: 16, imageName: "xmark", backgroundColor: .bColor200, tintColor: .white, cornerRadius: 15)
        
        xButton.addTarget(self, action: #selector(xButtonTapped), for: .touchUpInside)
        
        xButton.snp.makeConstraints { make in
            make.size.equalTo(42)
        }
        
        
        let customXButton = UIBarButtonItem(customView: xButton)
        
        self.navigationItem.leftBarButtonItem = customXButton
    }
    
    //게시글 작성 취소 버튼
    @objc func xButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: 왼쪽 네비바 버튼, Back Button <
    func setBackButton() {
        let backButton = GImageButton(imageSize: 20, imageName: "chevron.backward", backgroundColor: .clear, tintColor: .white, cornerRadius: 0)
        
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        
        let customBackButton = UIBarButtonItem(customView: backButton)
        
        self.navigationItem.leftBarButtonItem = customBackButton
    }
    
    //이전 뷰로 화면 전환
    @objc func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
}
