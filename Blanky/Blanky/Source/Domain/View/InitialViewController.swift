//
//  SplashViewController.swift
//  Blanky
//
//  Created by Yeri Hwang on 2023/11/16.
//

import UIKit

final class InitialViewController: UIViewController {
    
    // TODO: 네트워크 오류 알럿, 런치스크린 로티, 자동 로그인
    
    private let LoginStatus = UserLoginManager.shared.isLogin
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Debeg
        UserLoginManager.shared.isLogin = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print(#function, "스플래쉬 화면 진입")
        
        print("로그인 여부: ", LoginStatus)
        
        if LoginStatus == false {
            // 루트뷰 == 로그인 화면
            switchToLoginVC()
        } else {
            // 루트뷰 == 피드 화면
            switchToFeedVC()
        }
        
    }
    
    private func switchToLoginVC() {
        let loginVC = LoginViewController()
        let vc = UINavigationController(rootViewController: loginVC)
        RootVCManager.shared.changeRootVC(vc)
    }
    
    private func switchToFeedVC() {
        let tabBar = UITabBarController()
        
        let homeVC = HomeViewController()
        let firstVC = UINavigationController(rootViewController: homeVC)
        firstVC.tabBarItem = UITabBarItem(title: .none, image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house"))
        
        let tempVC = PostViewController()
        let secondVC = UINavigationController(rootViewController: tempVC)
        secondVC.tabBarItem = UITabBarItem(title: .none, image: UIImage(systemName: "star"), selectedImage: UIImage(systemName: "star"))
        
        tabBar.viewControllers = [firstVC, secondVC]
        tabBar.tabBar.backgroundColor = UIColor.systemBackground
        tabBar.tabBar.tintColor = UIColor.label
        tabBar.selectedIndex = 0
        
        RootVCManager.shared.changeRootVC(tabBar)
    }
    
    
}

