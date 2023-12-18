//
//  SplashViewController.swift
//  Blanky
//
//  Created by Yeri Hwang on 2023/11/16.
//

import UIKit

final class InitialViewController: UIViewController {
    
    // TODO: 네트워크 오류 알럿, 런치스크린 로티
    
    private let LoginStatus = UserLoginManager.shared.isLogin
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Debeg
        UserLoginManager.shared.isLogin = true
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
        
        //MARK: Tab 홈, 랭킹, 프로필, 댓글/알림?
        
        let homeVC = HomeViewController()
        let firstVC = UINavigationController(rootViewController: homeVC)
        firstVC.tabBarItem = UITabBarItem(title: .none, image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
        
        let profileVC = ProfileViewController()
        let secondVC = UINavigationController(rootViewController: profileVC)
        secondVC.tabBarItem = UITabBarItem(title: .none, image: UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person.fill"))
        
        tabBar.viewControllers = [firstVC, secondVC]
        tabBar.tabBar.backgroundColor = UIColor.systemBackground
        tabBar.tabBar.tintColor = UIColor.label
        tabBar.selectedIndex = 0
        
        RootVCManager.shared.changeRootVC(tabBar)
    }
    
    
}

/*
    고민되는 기능
    1. 홈 화면 - 서치 버튼, 메인 피드에서 베스트 댓글 보여주기, 조회수?
    2. 탭 추가? 랭킹 뷰, 댓글이나 알림 탭
    3. 프로필 설정 화면: 내 프로필 수정, 문의 남기기, 알림 설정, 로그아웃, 회원탈퇴
    4. 답댓글
    
    해야하는 기능
    1. 디테일 뷰 - 이미지 컬렉션뷰
    2. 프로필 탭 - 작성한 게시글, 좋아요한 게시글 테이블뷰(+헤더뷰)
    3. 댓글 삭제
 
    구현한 기능
    - 댓글, 좋아요, 페이지네이션, 게시글 CR, 프로필 조회, 좋아요한 게시글 조회, 로그인, 회원가입, 스크롤 버튼, 토큰 갱신
 
    * 메인 피드 베스트 댓글 보여주기, 랭킹 뷰
    * 스유 차트 써서 개인 플젝 하나 추가
    * 쇼핑 앱 찜하기 탭 다른 UI로 구현하기
 
 */
