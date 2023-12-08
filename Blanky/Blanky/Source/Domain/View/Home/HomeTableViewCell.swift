//
//  HomeTableViewCell.swift
//  Blanky
//
//  Created by Yeri Hwang on 2023/12/03.
//

import UIKit
import SnapKit
import Then

final class HomeTableViewCell: BaseTableViewCell {

    let profileImageView = UIImageView().then {
        $0.image = UIImage(named: "ghost")
        $0.layer.cornerRadius = 13
        $0.layer.borderWidth = 0.5
        $0.layer.borderColor = UIColor.bColor300.cgColor
        $0.contentMode = .scaleAspectFit
        $0.layer.masksToBounds = true
    }
    
    let nicknameLabel = GLabel(
        text: "익명의유령",
        fontWeight: .medium,
        fontSize: .XS)
    
    let dateLabel = GLabel(
        text: "",
        fontWeight: .thin,
        fontSize: .XXS)
    
    let titleLabel = GLabel(
        text: "",
        fontWeight: .semiBold,
        fontSize: .M)
    
    let contentLabel = GLabel(
        text: "",
        fontWeight: .regular,
        fontSize: .S)
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout()).then {
        $0.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: HomeCollectionViewCell.identifier)
        $0.backgroundColor = .bColor200
    }
    
    private func collectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        let size = UIScreen.main.bounds.width / 3.0
        layout.itemSize = CGSize(width: size - 30, height: 100)
        return layout
    }
    
//    private func collectionViewLayout() -> UICollectionViewLayout {
//        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
//        let item = NSCollectionLayoutItem(layoutSize: itemSize)
//        
//        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
//        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 1)
//        group.interItemSpacing = .fixed(10)
//        
//        let section = NSCollectionLayoutSection(group: group)
//        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
//        section.interGroupSpacing = 10
//        section.orthogonalScrollingBehavior = .continuous
//        
//        let layout = UICollectionViewCompositionalLayout(section: section)
//        
//        return layout
//    }
    
    let hitsImage = UIImageView().then {
        $0.image = UIImage(systemName: "eyes")
        $0.contentMode = .scaleAspectFit
        $0.tintColor = .white
    }
    
    let hitsLabel = GLabel(
        text: "0",
        fontWeight: .regular,
        fontSize: .XS)
    
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
        fontSize: .XS)
    
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
        fontSize: .XS)
    
    let bookmarkButton = GImageButton(
        imageSize: 14,
        imageName: "bookmark",
        backgroundColor: .bColor200,
        tintColor: .white,
        cornerRadius: 0
    )

    override func configureHierarchy() {
        [profileImageView, nicknameLabel, dateLabel, titleLabel, contentLabel, collectionView, 
         hitsImage, hitsLabel,messageButton, messageLabel, likeButton, likeLabel, bookmarkButton].forEach {
            contentView.addSubview($0)
        }
    }
    
    override func configureLayout() {
        profileImageView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(10)
            make.size.equalTo(25)
        }
        
        nicknameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(profileImageView)
            make.leading.equalTo(profileImageView.snp.trailing).offset(5)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.bottom.equalTo(nicknameLabel)
            make.leading.equalTo(nicknameLabel.snp.trailing).offset(5)
            make.trailing.equalToSuperview().inset(10)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.bottom).offset(15)
            $0.leading.equalTo(profileImageView)
            $0.trailing.equalToSuperview().inset(10)
        }
        
        contentLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.horizontalEdges.equalTo(titleLabel)
            $0.height.lessThanOrEqualTo(120)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(contentLabel.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(titleLabel)
            make.height.equalTo(200)
        }
        
        hitsImage.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).offset(10)
            make.leading.equalTo(collectionView).inset(5)
            make.size.equalTo(16)
            make.bottom.equalToSuperview().inset(10)
        }
        
        hitsLabel.snp.makeConstraints { make in
            make.centerY.equalTo(hitsImage)
            make.leading.equalTo(hitsImage.snp.trailing).offset(5)
            make.bottom.equalTo(hitsImage)
        }
        
        messageButton.snp.makeConstraints { make in
            make.top.equalTo(hitsLabel)
            make.leading.equalTo(hitsLabel.snp.trailing).offset(12)
            make.bottom.equalTo(hitsImage)
        }
        
        messageLabel.snp.makeConstraints { make in
            make.centerY.equalTo(messageButton)
            make.leading.equalTo(messageButton.snp.trailing).offset(5)
            make.bottom.equalTo(hitsImage)
        }
        
        likeButton.snp.makeConstraints { make in
            make.top.equalTo(hitsLabel)
            make.leading.equalTo(messageLabel.snp.trailing).offset(12)
            make.bottom.equalTo(hitsImage)
        }
        
        likeLabel.snp.makeConstraints { make in
            make.centerY.equalTo(likeButton)
            make.leading.equalTo(likeButton.snp.trailing).offset(5)
            make.bottom.equalTo(hitsImage)
        }
        
        bookmarkButton.snp.makeConstraints { make in
            make.top.equalTo(hitsImage).offset(-10)
            make.trailing.equalTo(collectionView).inset(10)
            make.bottom.equalToSuperview().inset(5)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        nicknameLabel.text = "익명의유령"
        dateLabel.text = ""
        titleLabel.text = ""
        contentLabel.text = ""
        hitsLabel.text = "0"
        messageLabel.text = "0"
        likeLabel.text = "0"
    }
}
