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
        $0.layer.cornerRadius = 30
    }
    
    let nicknameLabel = GLabel(
        text: "nickname",
        fontWeight: .semiBold,
        fontSize: .S)
    
    let dateLabel = GLabel(
        text: "date",
        fontWeight: .thin,
        fontSize: .S)
    
    let contentLabel = GLabel(
        text: "content content content content content content content",
        fontWeight: .semiBold,
        fontSize: .XS)
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout()).then {
        $0.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: HomeCollectionViewCell.identifier)
        $0.backgroundColor = .bColor200
    }
    
    private func collectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        let size = UIScreen.main.bounds.width - 40
        layout.itemSize = CGSize(width: size / 3, height: size / 3)
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
    
    let stackView = UIStackView().then {
        //$0.translatesAutoresizingMaskIntoConstraints = false
        //$0.isLayoutMarginsRelativeArrangement = true
        //$0.layoutMargins.left = 15.0
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.spacing = 5
    }
    
    let hitsButton = UIButton().then {
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 10, weight: .medium)
        let image = UIImage(systemName: "star", withConfiguration: imageConfig)
        $0.setImage(image, for: .normal)
        $0.setTitle("10", for: .normal)
        $0.tintColor = .white
        $0.contentMode = .scaleAspectFit
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func configureHierarchy() {
        [profileImageView, nicknameLabel, dateLabel, contentLabel, collectionView, stackView].forEach {
            contentView.addSubview($0)
        }
        
        [hitsButton].forEach {
            stackView.addArrangedSubview($0)
        }
    }
    
    override func configureLayout() {
        profileImageView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(10)
            make.size.equalTo(25)
        }
        
        nicknameLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImageView)
            make.leading.equalTo(profileImageView.snp.trailing).offset(10)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImageView)
            make.leading.equalTo(nicknameLabel.snp.trailing).offset(5)
        }
        
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(nicknameLabel.snp.bottom).offset(5)
            make.leading.equalTo(profileImageView)
            make.trailing.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(contentLabel.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(contentLabel)
            make.height.equalTo(200)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(contentLabel)
        }
    }

}
