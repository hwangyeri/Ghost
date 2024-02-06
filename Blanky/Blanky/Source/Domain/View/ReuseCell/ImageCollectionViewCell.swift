//
//  ImageCollectionViewCell.swift
//  Blanky
//
//  Created by Yeri Hwang on 2023/12/03.
//

import UIKit
import SnapKit
import Then

final class ImageCollectionViewCell: BaseCollectionViewCell {
    
    //MEMO: 낚시용 이미지 고려해서 1번 이미지 크게 보여주기
    
    let imageView = GBorderImageView(
        borderWidth: 1,
        cornerRadius: 22
    ).then {
        $0.backgroundColor = .bColor200
    }
    
    let backView = UIView().then {
        $0.backgroundColor = UIColor.bColor200.withAlphaComponent(0.8)
        $0.layer.cornerRadius = 12
    }
    
    let imageCountLabel = GLabel(
        text: "1/5",
        fontWeight: .medium,
        fontSize: .XXXS
    )
    
    override func configureHierarchy() {
        [imageView, backView].forEach {
            contentView.addSubview($0)
        }
        
        backView.addSubview(imageCountLabel)
    }
    
    override func configureLayout() {
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        backView.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview().inset(20)
            make.width.equalTo(32)
            make.height.equalTo(25)
        }
        
        imageCountLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageCountLabel.text = ""
    }
    
}
