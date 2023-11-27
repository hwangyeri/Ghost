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
    
    //MARK: Custom NavigationBarItem(Left) - BackButton
    func setCustomBackButton() {
        let backButton = GImageButton(imageSize: 18, imageName: "chevron.backward", backgroundColor: .bColor200, tintColor: .white, cornerRadius: 15)
        
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        
        backButton.snp.makeConstraints { make in
            make.size.equalTo(44)
        }
        
        
        let customBackButton = UIBarButtonItem(customView: backButton)
        
        self.navigationItem.leftBarButtonItem = customBackButton
    }
    
    //이전 뷰로 화면 전환
    @objc func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: Custom NavigationBarItem(Right) - ExitButton 나가기 버튼
    func setCustomExitButton() {
        let exitButton = GImageButton(imageSize: 16, imageName: "xmark", backgroundColor: .bColor200, tintColor: .white, cornerRadius: 15)
        
        exitButton.addTarget(self, action: #selector(exitButtonTapped), for: .touchUpInside)
        
        exitButton.snp.makeConstraints { make in
            make.size.equalTo(44)
        }
        
        let customExitButton = UIBarButtonItem(customView: exitButton)
        
        self.navigationItem.rightBarButtonItem = customExitButton
    }
    
    
    //루트뷰로 화면 전환
    @objc func exitButtonTapped() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
}
