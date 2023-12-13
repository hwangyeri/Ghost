//
//  HomeTableViewCell.swift
//  Blanky
//
//  Created by Yeri Hwang on 2023/12/03.
//

import UIKit
import SnapKit
import Then
import Kingfisher

final class HomeTableViewCell: BaseTableViewCell {
    
    var postData: PostData? {
        didSet {
            collectionView.reloadData()
            updateCollectionViewHeight()
            print("postData didSet")
        }
    }
    
    let profileImageView = GBorderImageView(
        borderWidth: 0.5,
        cornerRadius: 15
    )
    
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
        $0.delegate = self
        $0.dataSource = self
    }
    
    private func collectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 10
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = spacing
        layout.sectionInset = UIEdgeInsets(top: spacing, left: 0, bottom: spacing, right: spacing)
        layout.scrollDirection = .horizontal
        let width = UIScreen.main.bounds.width - 70
        layout.itemSize = CGSize(width: width, height: width)
        return layout
    }
    
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
            make.size.equalTo(30)
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
            $0.leading.equalTo(profileImageView).inset(10)
            $0.trailing.equalToSuperview().inset(10)
        }
        
        contentLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.horizontalEdges.equalTo(titleLabel)
            $0.height.lessThanOrEqualTo(120)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(contentLabel.snp.bottom).offset(10)
            make.leading.equalTo(titleLabel)
            make.trailing.equalToSuperview()
            make.height.equalTo(UIScreen.main.bounds.width - 70)
            //            make.height.equalTo(UIScreen.main.bounds.height / 2)
        }
        
        hitsImage.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).offset(10)
            make.leading.equalTo(collectionView)
            make.size.equalTo(16)
            make.bottom.equalToSuperview().inset(15)
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
            make.trailing.equalTo(collectionView).inset(20)
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
    
    // 데이터 없는 컬렉션뷰 높이 재조정 메서드
    private func updateCollectionViewHeight() {
        if postData?.image.isEmpty == true {
            collectionView.snp.updateConstraints { make in
                make.height.equalTo(0)
            }
        } else {
            collectionView.snp.updateConstraints { make in
                make.height.equalTo(UIScreen.main.bounds.width - 40)
            }
        }
    }
}

extension HomeTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return postData?.image.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.identifier, for: indexPath) as? HomeCollectionViewCell,
            let imageUrl = postData?.image[indexPath.item] else {
                return UICollectionViewCell()
        }

        // 헤더 설정
        let modifier = AnyModifier { request in
            var headers = request
            headers.setValue(KeychainManager.shared.token, forHTTPHeaderField: Constant.authorization)
            headers.setValue(APIKey.sesacKey, forHTTPHeaderField: Constant.sesacKey)
            return headers
        }

        // 이미지 로드
        cell.imageView.kf.setImage(
            with: URL(string: APIKey.baseURL + imageUrl),
            placeholder: UIImage(named: "ghost"),
            options: [.requestModifier(modifier)]
        )

        return cell
    }
    
    
}
