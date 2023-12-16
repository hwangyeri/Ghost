//
//  HomeCollectionViewCell.swift
//  Blanky
//
//  Created by Yeri Hwang on 2023/12/03.
//

import UIKit
import SnapKit
import Then

final class HomeCollectionViewCell: BaseCollectionViewCell {
    
    //MEMO: 낚시용 이미지 고려해서 1번 이미지 크게 보여주기
    
    let imageView = GBorderImageView(
        borderWidth: 1,
        cornerRadius: 25
    ).then {
        $0.backgroundColor = .bColor200
    }
    
    let backView = UIView().then {
        $0.backgroundColor = UIColor.bColor200
        $0.layer.cornerRadius = 8
    }
    
    let imageCountLabel = GLabel(
        text: "1/5",
        fontWeight: .medium,
        fontSize: .XXS
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
            make.bottom.trailing.equalToSuperview().inset(35)
            make.width.equalTo(30)
            make.height.equalTo(28)
        }
        
        imageCountLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageCountLabel.text = "1/5"
    }
    
}
