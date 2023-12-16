//
//  PostTableViewCell.swift
//  Blanky
//
//  Created by Yeri Hwang on 2023/12/14.
//

import UIKit
import SnapKit

final class PostTableViewCell: BaseTableViewCell {
    
    let profileImageView = GBorderImageView(
        borderWidth: 1,
        cornerRadius: 17
    )
    
    let nicknameLabel = GLabel(
        text: "익명의 유령",
        fontWeight: .regular,
        fontSize: .XS
    )
    
    let dateLabel = GLabel(
        text: "7시간 전",
        fontWeight: .thin,
        fontSize: .XXS
    )

    let titleLabel = GLabel(
        text: "타이틀 라벨 입니다.",
        fontWeight: .semiBold,
        fontSize: .XL
    )
    
    let contentLabel = GLabel(
        text: "컨텐츠 라벨 입니다.",
        fontWeight: .regular,
        fontSize: .M
    )
    
    let likeButton = GImageButton(
        imageSize: 18,
        imageName: Constant.heart,
        backgroundColor: .bColor200,
        tintColor: .white,
        cornerRadius: 0
    )
    
    let likeLabel = GLabel(
        text: "0",
        fontWeight: .regular,
        fontSize: .XS
    )
    
    let messageButton = GImageButton(
        imageSize: 16,
        imageName: Constant.message,
        backgroundColor: .bColor200,
        tintColor: .white,
        cornerRadius: 0
    )
    
    let messageLabel = GLabel(
        text: "0",
        fontWeight: .regular,
        fontSize: .XS
    )
    
    let divider = GDivider().then {
        $0.backgroundColor = .bColor300
    }
    
    override func configureHierarchy() {
        [profileImageView, nicknameLabel, titleLabel, contentLabel, likeButton, likeLabel, messageButton, messageLabel, dateLabel, divider].forEach {
            contentView.addSubview($0)
        }
    }
    
    override func configureLayout() {
        profileImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(5)
            make.leading.equalToSuperview().inset(12)
            make.size.equalTo(35)
        }
        
        nicknameLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.top).offset(3)
            make.leading.equalTo(profileImageView.snp.trailing).offset(8)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(nicknameLabel.snp.bottom).offset(2)
            make.leading.equalTo(nicknameLabel)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(20)
            make.leading.equalTo(profileImageView).inset(5)
            make.trailing.equalToSuperview().inset(10)
        }
        
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(titleLabel)
        }
        
        likeButton.snp.makeConstraints { make in
            make.top.equalTo(contentLabel.snp.bottom).offset(30)
            make.leading.equalTo(titleLabel)
        }
        
        likeLabel.snp.makeConstraints { make in
            make.centerY.equalTo(likeButton)
            make.leading.equalTo(likeButton.snp.trailing).offset(5)
        }
        
        messageButton.snp.makeConstraints { make in
            make.top.equalTo(likeButton)
            make.leading.equalTo(likeLabel.snp.trailing).offset(15)
            make.bottom.equalTo(likeButton)
        }
        
        messageLabel.snp.makeConstraints { make in
            make.centerY.equalTo(messageButton)
            make.leading.equalTo(messageButton.snp.trailing).offset(5)
        }
        
        divider.snp.makeConstraints { make in
            make.top.equalTo(likeButton.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
            make.height.equalTo(0.5)
            make.bottom.equalToSuperview()
        }
    }

    
}
