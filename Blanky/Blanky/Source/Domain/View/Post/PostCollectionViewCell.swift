//
//  PostCollectionViewCell.swift
//  Blanky
//
//  Created by Yeri Hwang on 2023/12/03.
//

import UIKit
import SnapKit
import Then

final class PostCollectionViewCell: BaseCollectionViewCell {
    
    let deleteButton = GImageButton(
        imageSize: 10,
        imageName: "xmark",
        backgroundColor: .bColor300.withAlphaComponent(0.9),
        tintColor: .white,
        cornerRadius: 13
    )
    
    let imageView = GBorderImageView(
        borderWidth: 1,
        cornerRadius: 18
    ).then {
        $0.image = UIImage(systemName: "exclamationmark.icloud")
        $0.backgroundColor = .bColor100
    }
    
    override func configureHierarchy() {
        [imageView, deleteButton].forEach {
            self.addSubview($0)
        }
    }
    
    override func configureLayout() {
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
        }
        
        deleteButton.snp.makeConstraints { make in
            make.top.equalTo(imageView).offset(-3)
            make.trailing.equalTo(imageView).offset(3)
            make.size.equalTo(25)
        }
    }
    
}
