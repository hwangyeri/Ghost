//
//  FirstSwipeTableViewCell.swift
//  Blanky
//
//  Created by Yeri Hwang on 2023/12/20.
//

import UIKit
import SnapKit
import Then

class FirstSwipeTableViewCell: BaseTableViewCell {

    let postImageView = GBorderImageView(
        borderWidth: 1,
        cornerRadius: 10
    )

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
    
    let commentButton = GTextButton(text: "3").then {
        $0.backgroundColor = .bColor200
        $0.layer.borderColor = UIColor.bColor300.cgColor
        $0.layer.borderWidth = 0.5
        $0.layer.cornerRadius = 20
    }
    
    override func configureHierarchy() {
        [postImageView, titleLabel, dateLabel, commentButton].forEach {
            contentView.addSubview($0)
        }
    }
    
    override func configureLayout() {
        postImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(10)
            make.centerY.equalToSuperview()
            make.size.equalTo(55)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.leading.equalTo(postImageView.snp.trailing).offset(10)
            make.trailing.equalTo(commentButton.snp.leading).offset(-20)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.horizontalEdges.equalTo(titleLabel)
            make.bottom.equalToSuperview().inset(20)
        }
        
        commentButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(20)
            make.centerY.equalToSuperview()
            make.size.equalTo(40)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        postImageView.image = UIImage(named: Constant.ghost)
        titleLabel.text = ""
        dateLabel.text = ""
        commentButton.setTitle("", for: .normal)
    }
   
}
