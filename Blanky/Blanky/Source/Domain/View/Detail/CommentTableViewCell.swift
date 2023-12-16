//
//  CommentTableViewCell.swift
//  Blanky
//
//  Created by Yeri Hwang on 2023/12/14.
//

import UIKit
import SnapKit

final class CommentTableViewCell: BaseTableViewCell {

    let dateLabel = GLabel(
        text: "15:30",
        fontWeight: .thin,
        fontSize: .XXS
    )
    
    let deleteButton = GImageButton(
        imageSize: 15,
        imageName: Constant.trash,
        backgroundColor: .bColor200,
        tintColor: .systemPink,
        cornerRadius: 0
    )
    
    let commentLabel = GLabel(
        text: "댓글 내용 입니다.",
        fontWeight: .regular,
        fontSize: .S
    )
    
    let divider = GDivider().then { 
        $0.backgroundColor = .bColor300
    }
    
    override func configureHierarchy() {
        [dateLabel, deleteButton, commentLabel, divider].forEach {
            contentView.addSubview($0)
        }
    }
    
    override func configureLayout() {
        dateLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().inset(12)
        }
        
        deleteButton.snp.makeConstraints { make in
            make.top.equalTo(dateLabel)
            make.trailing.equalToSuperview().inset(12)
        }
        
        commentLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(10)
            make.leading.equalTo(dateLabel)
            make.trailing.equalTo(deleteButton)
        }
        
        divider.snp.makeConstraints { make in
            make.top.equalTo(commentLabel.snp.bottom).offset(15)
            make.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
            make.bottom.equalToSuperview().inset(12)
            make.height.equalTo(0.5)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        dateLabel.text = ""
        commentLabel.text = ""
    }

}
