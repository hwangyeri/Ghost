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
        imageSize: 12,
        imageName: "xmark",
        backgroundColor: .bColor200,
        tintColor: .white,
        cornerRadius: 15
    )
    
    let imageView = GBorderImageView(
        borderWidth: 1,
        cornerRadius: 25
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
            make.edges.equalToSuperview()
        }
        
        deleteButton.snp.makeConstraints { make in
            make.top.trailing.equalTo(imageView)
            make.size.equalTo(30)
        }
    }
    
}
