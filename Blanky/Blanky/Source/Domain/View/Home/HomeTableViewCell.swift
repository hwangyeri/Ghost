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
    
    var postData: PostData? {
        didSet {
            collectionView.reloadData()
            updateCollectionViewHeight()
            updateBackViewHeight()
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
        fontSize: .XS
    )
    
    let dateLabel = GLabel(
        text: "",
        fontWeight: .thin,
        fontSize: .XXS
    )
    
    let titleLabel = GLabel(
        text: "",
        fontWeight: .semiBold,
        fontSize: .M
    )
    
    let contentLabel = GLabel(
        text: "",
        fontWeight: .regular,
        fontSize: .S
    )
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout()).then {
        $0.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: ImageCollectionViewCell.identifier)
        $0.backgroundColor = .bColor200
        $0.delegate = self
        $0.dataSource = self
    }
    
    private func collectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
//        let spacing: CGFloat = 10
        layout.minimumLineSpacing = 20
//        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        layout.scrollDirection = .horizontal
        let width = UIScreen.main.bounds.width - 80
        layout.itemSize = CGSize(width: width, height: width - 50)
        return layout
    }
    
//    let hitsImage = UIImageView().then {
//        $0.image = UIImage(systemName: "eyes")
//        $0.contentMode = .scaleAspectFit
//        $0.tintColor = .white
//    }
//    
//    let hitsLabel = GLabel(
//        text: "0",
//        fontWeight: .regular,
//        fontSize: .XS
//    )
    
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
        fontSize: .XS
    )
    
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
        fontSize: .XS
    )
    
//    let bookmarkButton = GImageButton(
//        imageSize: 14,
//        imageName: "bookmark",
//        backgroundColor: .bColor200,
//        tintColor: .white,
//        cornerRadius: 0
//    )
    
    let backView = UIView().then {
        $0.backgroundColor = .bColor300.withAlphaComponent(0.8)
        $0.layer.cornerRadius = 14
    }
    
    let commentTitleLabel = GLabel(
        text: "댓글",
        fontWeight: .medium,
        fontSize: .XXS
    )
    
    let commentProfileImageView = GBorderImageView(
        borderWidth: 0.5,
        cornerRadius: 10
    )
    
    let commentContentLabel = GLabel(
        text: "댓글입니다.",
        fontWeight: .regular,
        fontSize: .XXS
    ).then {
        $0.numberOfLines = 2
    }
    
    let chevronDownImageView = UIImageView().then {
        $0.image = UIImage(systemName: "chevron.down")
        $0.contentMode = .scaleAspectFit
        $0.tintColor = .white
    }
    
    override func configureHierarchy() {
        [profileImageView, nicknameLabel, dateLabel, titleLabel, contentLabel, collectionView,
         messageButton, messageLabel, likeButton, likeLabel, backView].forEach {
            contentView.addSubview($0)
        }
        
        [commentTitleLabel, commentProfileImageView, commentContentLabel, chevronDownImageView].forEach {
            backView.addSubview($0)
        }
        
//        collectionView.backgroundColor = .point
//        contentView.backgroundColor = .systemPink
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
            make.leading.equalTo(nicknameLabel.snp.trailing).offset(6)
            make.trailing.equalToSuperview().inset(10)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.bottom).offset(15)
            $0.leading.equalTo(profileImageView).inset(5)
            $0.trailing.equalToSuperview().inset(10)
        }
        
        contentLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.horizontalEdges.equalTo(titleLabel)
            $0.height.lessThanOrEqualTo(100)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(contentLabel.snp.bottom)
            make.leading.equalTo(titleLabel)
            make.trailing.equalToSuperview()
            make.height.equalTo(UIScreen.main.bounds.width - 100)
        }
        
//        hitsImage.snp.makeConstraints { make in
//            make.top.equalTo(collectionView.snp.bottom).offset(10)
//            make.leading.equalTo(collectionView)
//            make.size.equalTo(16)
//            make.bottom.equalToSuperview().inset(15)
//        }
//        
//        hitsLabel.snp.makeConstraints { make in
//            make.centerY.equalTo(hitsImage)
//            make.leading.equalTo(hitsImage.snp.trailing).offset(5)
//            make.bottom.equalTo(hitsImage)
//        }
        
        messageButton.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom)
            make.leading.equalTo(collectionView)
            make.bottom.equalTo(backView.snp.top).offset(-10)
        }
        
        messageLabel.snp.makeConstraints { make in
            make.centerY.equalTo(messageButton)
            make.leading.equalTo(messageButton.snp.trailing).offset(5)
            make.bottom.equalTo(messageButton)
        }
        
        likeButton.snp.makeConstraints { make in
            make.top.equalTo(messageButton)
            make.leading.equalTo(messageLabel.snp.trailing).offset(12)
            make.bottom.equalTo(messageButton)
        }
        
        likeLabel.snp.makeConstraints { make in
            make.centerY.equalTo(likeButton)
            make.leading.equalTo(likeButton.snp.trailing).offset(5)
            make.bottom.equalTo(messageButton)
        }
        
//        bookmarkButton.snp.makeConstraints { make in
//            make.top.equalTo(hitsImage).offset(-10)
//            make.trailing.equalTo(collectionView).inset(20)
//            make.bottom.equalToSuperview().inset(5)
//        }
        
        backView.snp.makeConstraints { make in
            make.top.equalTo(messageButton.snp.bottom).offset(30)
            make.horizontalEdges.equalToSuperview().inset(10)
            make.bottom.equalToSuperview().inset(10)
        }
        
        commentTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.leading.equalToSuperview().inset(15)
        }
        
        commentProfileImageView.snp.makeConstraints { make in
            make.top.equalTo(commentTitleLabel.snp.bottom).offset(10)
            make.leading.equalTo(commentTitleLabel)
            make.size.equalTo(20)
        }
        
        commentContentLabel.snp.makeConstraints { make in
            make.top.equalTo(commentProfileImageView).offset(3)
            make.leading.equalTo(commentProfileImageView.snp.trailing).offset(5)
            make.trailing.equalToSuperview().inset(10)
            make.bottom.equalToSuperview().inset(20)
        }
        
        chevronDownImageView.snp.makeConstraints { make in
            make.bottom.trailing.equalToSuperview().inset(15)
            make.size.equalTo(17)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        dateLabel.text = ""
        titleLabel.text = ""
        contentLabel.text = ""
//        hitsLabel.text = "0"
        messageLabel.text = ""
        likeLabel.text = ""
        commentContentLabel.text = ""
    }
    
    // 이미지 데이터 없는 컬렉션뷰 높이 재조정 메서드
    private func updateCollectionViewHeight() {
        if postData?.image.isEmpty == true {
            collectionView.snp.updateConstraints { make in
                make.height.equalTo(15)
            }
        } else {
            collectionView.snp.updateConstraints { make in
                make.height.equalTo(UIScreen.main.bounds.width - 100)
            }
        }
    }
    
    // 댓글 데이터 없는 백뷰 높이 재조정 메서드
    private func updateBackViewHeight() {
        if postData?.comments.isEmpty == true {
            backView.snp.remakeConstraints { make in
                make.top.equalTo(messageButton.snp.bottom).offset(30)
                make.horizontalEdges.equalToSuperview().inset(10)
                make.bottom.equalToSuperview().inset(10)
                make.height.equalTo(0)
            }
        } else {
            backView.snp.remakeConstraints { make in
                make.top.equalTo(messageButton.snp.bottom).offset(30)
                make.horizontalEdges.equalToSuperview().inset(10)
                make.bottom.equalToSuperview().inset(10)
            }
        }
    }
}

extension HomeTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return postData?.image.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.identifier, for: indexPath) as? ImageCollectionViewCell,
            let imageUrl = postData?.image[indexPath.item] else {
                return UICollectionViewCell()
        }
    
        // 이미지 로드 + 다운샘플링
        cell.imageView.setImage(withURL: imageUrl, downsamplingSize: cell.imageView.bounds.size) { result in
            switch result {
            case .success(_):
                print("🩵 이미지 로드 성공")
                break
            case .failure(let error):
                print("💛 이미지 로드 실패: \(error)")
            }
        }
        
        let imageCount = "\(postData?.image.count ?? 0)"
        
        cell.imageCountLabel.text = "\(indexPath.row + 1)/\(imageCount)"

        return cell
    }
    
    
}
