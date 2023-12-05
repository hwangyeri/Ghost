//
//  PostCollectionViewCell.swift
//  Blanky
//
//  Created by Yeri Hwang on 2023/12/03.
//

import UIKit
import SnapKit
import Then

class PostCollectionViewCell: BaseCollectionViewCell {
    
    let deleteButton = GImageButton(
        imageSize: 12,
        imageName: "xmark",
        backgroundColor: .bColor200,
        tintColor: .white,
        cornerRadius: 15
    )
    
    let imageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.layer.masksToBounds = true
        $0.image = UIImage(systemName: "exclamationmark.icloud")
        $0.backgroundColor = .bColor100
        $0.layer.cornerRadius = 25
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.bColor300.cgColor
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
