//
//  ProfileViewController.swift
//  Blanky
//
//  Created by Yeri Hwang on 2023/12/13.
//

import UIKit
import RxSwift
import RxCocoa

/*
 프로필 화면
 - 내 프로필 조회: 내가 작성한 게시글 수, 이메일, 닉네임
 - 내가 좋아요한 게시글 조회: 좋아요한 글
 - 유저별 작성한 게시글 조회: 작성한 글
 */

final class ProfileViewController: BaseViewController {
    
    private let mainView = ProfileView()
    
    private let disposeBag = DisposeBag()
    
    private var profileData = ProfileMe(posts: [], _id: "", email: "", nick: "")
    
    override func loadView() {
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setProfileData()
        setLikeCountLabel()
    }
    
    override func configureLayout() {
        // 설정 버튼
        let settingButton = UIBarButtonItem(image: UIImage(systemName: "gearshape"), style: .plain, target: self, action: #selector(settingButtonTap))
        settingButton.tintColor = .white
        self.navigationItem.rightBarButtonItem = settingButton
    }
    
    @objc private func settingButtonTap() {
        print(#function)
        let vc = SettingViewController()
        vc.email = profileData.email
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func setProfileData() {
        // 내 프로필 조회 API
        PostAPIManager.shared.profileMe()
            .subscribe(with: self) { owner, result in
                switch result {
                case .success(let data):
                    print("내 프로필 조회 성공")
                    owner.profileData = data
                    owner.mainView.nicknameLabel.text = data.nick
                    owner.mainView.emailLabel.text = data.email
                    owner.mainView.postCountLabel.text = "\(data.posts.count)"
                case .failure(let error):
                    print("내 프로필 조회 실패: ",error.errorDescription)
                }
            }
            .disposed(by: disposeBag)
    }
    
    private func setLikeCountLabel() {
        // 좋아요한 게시글 조회 API
        PostAPIManager.shared.likeMe(next: "")
            .subscribe(with: self) { owner, result in
                switch result {
                case .success(let data):
                    print("좋아요한 게시글 조회 성공")
                    owner.mainView.likeCountLabel.text = "\(data.data.count)"
                case .failure(let error):
                    print("좋아요한 게시글 조회 실패", error.errorDescription)
                }
            }
            .disposed(by: disposeBag)
    }

}
