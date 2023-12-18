//
//  ProfileView.swift
//  Blanky
//
//  Created by Yeri Hwang on 2023/12/13.
//

import UIKit
import SnapKit
import Then

final class ProfileView: BaseView {
    
    let nicknameLabel = GLabel(
        text: "nickname",
        fontWeight: .semiBold,
        fontSize: .XL
    )
    
    let emailLabel = GLabel(
        text: "email",
        fontWeight: .regular,
        fontSize: .S
    ).then {
        $0.textColor = .gray
    }
    
    let profileImageView = GBorderImageView(
        borderWidth: 1 ,
        cornerRadius: 28
    )
    
    let postStackView = UIStackView().then {
        $0.isLayoutMarginsRelativeArrangement = true
        $0.axis = .vertical
        $0.distribution = .fill
        $0.alignment = .center
        $0.spacing = 0
    }
    
    let postLabel = GLabel(
        text: "게시글",
        fontWeight: .regular,
        fontSize: .XS
    )
    
    let postCountLabel = GLabel(
        text: "0",
        fontWeight: .semiBold,
        fontSize: .S
    )
    
    let likeStackView = UIStackView().then {
        $0.isLayoutMarginsRelativeArrangement = true
        $0.axis = .vertical
        $0.distribution = .fill
        $0.alignment = .center
        $0.spacing = 0
    }
    
    let likeLabel = GLabel(
        text: "좋아요",
        fontWeight: .regular,
        fontSize: .XS
    )
    
    let likeCountLabel = GLabel(
        text: "0",
        fontWeight: .semiBold,
        fontSize: .S
    )
    
    let commentStackView = UIStackView().then {
        $0.isLayoutMarginsRelativeArrangement = true
        $0.axis = .vertical
        $0.distribution = .fill
        $0.alignment = .center
        $0.spacing = 0
    }
    
    let commentLabel = GLabel(
        text: "댓글",
        fontWeight: .regular,
        fontSize: .XS
    )
    
    let commentCountLabel = GLabel(
        text: "0",
        fontWeight: .semiBold,
        fontSize: .S
    )
    
    let stackView = UIStackView().then {
        $0.isLayoutMarginsRelativeArrangement = true
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.spacing = 0
        $0.backgroundColor = .bColor100
    }
    
    lazy var tableView = UITableView().then {
        $0.rowHeight = UITableView.automaticDimension
        $0.estimatedRowHeight =  100
        $0.register(ProfileTableViewCell.self, forCellReuseIdentifier: ProfileTableViewCell.identifier)
        $0.backgroundColor = .bColor200
    }
    
    override func configureHierarchy() {
        [nicknameLabel, emailLabel, profileImageView, stackView, tableView].forEach {
            self.addSubview($0)
        }
        
        [postStackView, likeStackView, commentStackView].forEach {
            stackView.addArrangedSubview($0)
        }
        
        [postCountLabel, postLabel].forEach {
            postStackView.addArrangedSubview($0)
        }
        
        [likeCountLabel, likeLabel].forEach {
            likeStackView.addArrangedSubview($0)
        }
        
        [commentCountLabel, commentLabel].forEach {
            commentStackView.addArrangedSubview($0)
        }
    }
    
    override func configureLayout() {
        nicknameLabel.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).inset(20)
            make.leading.equalToSuperview().inset(20)
        }
        
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(nicknameLabel.snp.bottom).offset(10)
            make.leading.equalTo(nicknameLabel)
        }
        
        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).inset(12)
            make.trailing.equalToSuperview().inset(20)
            make.size.equalTo(55)
        }
        
        postStackView.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(15)
        }
        
        likeStackView.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(15)
        }
        
        commentStackView.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(15)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(emailLabel.snp.bottom).offset(5)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(80)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(self.safeAreaLayoutGuide)
        }
    }
    
}
