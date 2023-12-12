//
//  SplashViewController.swift
//  Blanky
//
//  Created by Yeri Hwang on 2023/11/16.
//

import UIKit
import SnapKit

final class SplashViewController: UIViewController {
    
    // TODO: 네트워크 오류 알럿, 런치스크린 로티
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Debeg
        UserLoginManager.shared.isLogin = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print(#function, "스플래쉬 화면 진입")
        
        let LoginStatus = UserLoginManager.shared.isLogin
        print("로그인 여부: ", LoginStatus)
        
        if LoginStatus == false {
            // 첫화면 == 로그인 화면
            switchToLoginVC()
        } else {
            // 첫화면 == 피드 화면
            switchToFeedVC()
        }
    }
    
    private func switchToLoginVC() {
        let loginVC = LoginViewController()
        navigationController?.pushViewController(loginVC, animated: true)
    }
    
    private func switchToFeedVC() {
        let tabBar = UITabBarController()
        
        let firstVC = HomeViewController()
        firstVC.tabBarItem = UITabBarItem(title: .none, image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house"))
        
        let secondVC = PostViewController()
        secondVC.tabBarItem = UITabBarItem(title: .none, image: UIImage(systemName: "star"), selectedImage: UIImage(systemName: "star"))
        
        tabBar.viewControllers = [firstVC, secondVC]
        tabBar.tabBar.backgroundColor = UIColor.systemBackground
        tabBar.tabBar.tintColor = UIColor.label
        tabBar.selectedIndex = 0
        
        navigationController?.pushViewController(tabBar, animated: true)
    }
    
    
}

