//
//  SecondSwipeCollectionViewCell.swift
//  Blanky
//
//  Created by Yeri Hwang on 2023/12/20.
//

import UIKit
import SnapKit
import Then

final class SecondSwipeCollectionViewCell: BaseCollectionViewCell {
    
    let postImageView = UIImageView().then {
        $0.image = UIImage(named: "ghost")
        $0.contentMode = .scaleAspectFill
        $0.layer.masksToBounds = true
    }

    let titleLabel = GLabel(
        text: "타이틀 라벨 입니다.",
        fontWeight: .regular,
        fontSize: .M
    ).then {
        $0.numberOfLines = 1
    }
    
    let dateLabel = GLabel(
        text: "7시간 전",
        fontWeight: .thin,
        fontSize: .XXS
    )
    
    let messageButton = GImageButton(
        imageSize: 13,
        imageName: "message",
        backgroundColor: .bColor200,
        tintColor: .white,
        cornerRadius: 0
    )
    
    let messageLabel = GLabel(
        text: "0",
        fontWeight: .regular,
        fontSize: .XS
    )
    
    let likeButton = GImageButton(
        imageSize: 15,
        imageName: "heart",
        backgroundColor: .bColor200,
        tintColor: .white,
        cornerRadius: 0
    )
    
    let likeLabel = GLabel(
        text: "0",
        fontWeight: .regular,
        fontSize: .XS
    )
    
    override func configureHierarchy() {
        [postImageView, titleLabel, dateLabel, messageButton, messageLabel, likeButton, likeLabel].forEach {
            contentView.addSubview($0)
        }
    }
    
    override func configureLayout() {
        postImageView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
            make.size.equalTo(UIScreen.main.bounds.width / 2)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(postImageView.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview().inset(10)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.horizontalEdges.equalTo(titleLabel)
        }
        
        messageButton.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().inset(10)
            make.bottom.equalToSuperview().inset(8)
        }
        
        messageLabel.snp.makeConstraints { make in
            make.centerY.equalTo(messageButton)
            make.leading.equalTo(messageButton.snp.trailing).offset(5)
            make.bottom.equalTo(messageButton)
        }
        
        likeButton.snp.makeConstraints { make in
            make.top.equalTo(messageButton)
            make.leading.equalTo(messageLabel.snp.trailing).offset(10)
            make.bottom.equalTo(messageButton)
        }
        
        likeLabel.snp.makeConstraints { make in
            make.centerY.equalTo(likeButton)
            make.leading.equalTo(likeButton.snp.trailing).offset(5)
            make.bottom.equalTo(messageButton)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        postImageView.image = UIImage(named: Constant.ghost)
        dateLabel.text = ""
        titleLabel.text = ""
        messageLabel.text = ""
        likeLabel.text = ""
    }
    
}
