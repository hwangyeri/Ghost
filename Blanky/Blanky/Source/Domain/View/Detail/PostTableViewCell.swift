//
//  PostTableViewCell.swift
//  Blanky
//
//  Created by Yeri Hwang on 2023/12/14.
//

import UIKit
import SnapKit
import Kingfisher

final class PostTableViewCell: BaseTableViewCell {
    
    var postData: PostData? {
        didSet {
            collectionView.reloadData()
            updateCollectionViewHeight()
            print("postData didSet")
        }
    }
    
    let profileImageView = GBorderImageView(
        borderWidth: 1,
        cornerRadius: 17
    )
    
    let nicknameLabel = GLabel(
        text: "익명의 유령",
        fontWeight: .regular,
        fontSize: .XS
    )
    
    let dateLabel = GLabel(
        text: "7시간 전",
        fontWeight: .thin,
        fontSize: .XXS
    )

    let titleLabel = GLabel(
        text: "타이틀 라벨 입니다.",
        fontWeight: .semiBold,
        fontSize: .XL
    )
    
    let contentLabel = GLabel(
        text: "컨텐츠 라벨 입니다.",
        fontWeight: .regular,
        fontSize: .M
    )
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout()).then {
        $0.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: ImageCollectionViewCell.identifier)
        $0.backgroundColor = .bColor200
        $0.delegate = self
        $0.dataSource = self
    }
    
    private func collectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 10
        layout.minimumLineSpacing = spacing * 2
        layout.minimumInteritemSpacing = spacing
        layout.sectionInset = UIEdgeInsets(top: spacing, left: 5, bottom: spacing, right: spacing)
        layout.scrollDirection = .horizontal
        let width = UIScreen.main.bounds.width
        layout.itemSize = CGSize(width: width - 50, height: width - 60)
        return layout
    }
    
    let likeButton = GImageButton(
        imageSize: 18,
        imageName: Constant.heart,
        backgroundColor: .bColor200,
        tintColor: .white,
        cornerRadius: 0
    )
    
    let likeLabel = GLabel(
        text: "0",
        fontWeight: .regular,
        fontSize: .XXS
    )
    
    let messageButton = GImageButton(
        imageSize: 16,
        imageName: Constant.message,
        backgroundColor: .bColor200,
        tintColor: .white,
        cornerRadius: 0
    )
    
    let messageLabel = GLabel(
        text: "0",
        fontWeight: .regular,
        fontSize: .XXS
    )
    
    let divider = GDivider().then {
        $0.backgroundColor = .bColor300
    }
    
    weak var delegate: PostTableViewCellDelegate?
    
    override func configureHierarchy() {
        [profileImageView, nicknameLabel, titleLabel, contentLabel, collectionView, 
         messageButton, messageLabel, likeButton, likeLabel, dateLabel, divider].forEach {
            contentView.addSubview($0)
        }
        
        likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
    }
    
    @objc private func likeButtonTapped() {
        delegate?.likeButtonTapped()
    }
   
    override func configureLayout() {
        profileImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(5)
            make.leading.equalToSuperview().inset(12)
            make.size.equalTo(35)
        }
        
        nicknameLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.top).offset(3)
            make.leading.equalTo(profileImageView.snp.trailing).offset(8)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(nicknameLabel.snp.bottom).offset(2)
            make.leading.equalTo(nicknameLabel)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(20)
            make.leading.equalTo(profileImageView).inset(10)
            make.trailing.equalToSuperview().inset(10)
        }
        
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(titleLabel)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(contentLabel.snp.bottom).offset(10)
            make.leading.equalTo(titleLabel)
            make.trailing.equalToSuperview()
            make.height.equalTo(UIScreen.main.bounds.width - 60)
        }
        
        messageButton.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).offset(10)
            make.leading.equalTo(titleLabel)
        }
        
        messageLabel.snp.makeConstraints { make in
            make.centerY.equalTo(messageButton)
            make.leading.equalTo(messageButton.snp.trailing).offset(3)
        }
        
        likeButton.snp.makeConstraints { make in
            make.top.equalTo(messageButton)
            make.leading.equalTo(messageLabel.snp.trailing).offset(15)
            make.bottom.equalTo(messageButton)
        }
        
        likeLabel.snp.makeConstraints { make in
            make.centerY.equalTo(likeButton)
            make.leading.equalTo(likeButton.snp.trailing).offset(3)
        }
        
        divider.snp.makeConstraints { make in
            make.top.equalTo(likeButton.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
            make.height.equalTo(0.5)
            make.bottom.equalToSuperview()
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        dateLabel.text = ""
        titleLabel.text = ""
        contentLabel.text = ""
        messageLabel.text = ""
        likeLabel.text = ""
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

extension PostTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    
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
