//
//  SecondSwipeViewController.swift
//  Blanky
//
//  Created by Yeri Hwang on 2023/12/20.
//

import UIKit
import RxSwift
import RxCocoa
import Kingfisher

final class SecondSwipeViewController: BaseViewController {
    
    private let mainView = SecondSwipeView()
    
    private let disposeBag = DisposeBag()
    
    private var likePostData = PostRead(data: [], next_cursor: "")
    
    override func loadView() {
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setLikePostData()
    }
    
    override func configureLayout() {
        view.backgroundColor = .bColor200
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
    }
    
    private func showLoadingIndicator() {
        mainView.loadingIndicator.startAnimating()
    }
    
    private func hideLoadingIndicator() {
        mainView.loadingIndicator.stopAnimating()
        mainView.loadingIndicator.isHidden = true
    }
    
    private func setLikePostData() {
        // 좋아요한 게시글 조회 API
        PostAPIManager.shared.likeMe(next: "")
            .subscribe(with: self) { owner, result in
                switch result {
                case .success(let data):
                    print("좋아요한 게시글 조회 성공")
                    owner.likePostData = data
                    owner.mainView.collectionView.reloadData()
                case .failure(let error):
                    print("좋아요한 게시글 조회 실패", error.errorDescription)
                }
            }
            .disposed(by: disposeBag)
    }

}

extension SecondSwipeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return likePostData.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SecondSwipeCollectionViewCell.identifier, for: indexPath) as? SecondSwipeCollectionViewCell else { return UICollectionViewCell() }
        
        let row = likePostData.data[indexPath.item]
        
        cell.titleLabel.text = row.title
        cell.dateLabel.text = row.time
        cell.messageLabel.text = "\(row.comments.count)"
        cell.likeLabel.text = "\(row.likes.count)"
        
        if !row.image.isEmpty {
            let modifier = AnyModifier { request in
                var headers = request
                headers.setValue(KeychainManager.shared.token, forHTTPHeaderField: Constant.authorization)
                headers.setValue(APIKey.sesacKey, forHTTPHeaderField: Constant.sesacKey)
                return headers
            }
            
            cell.postImageView.kf.setImage(
                with: URL(string: APIKey.baseURL + (row.image[0])),
                placeholder: UIImage(named: "ghost"),
                options: [.requestModifier(modifier)]
            )
        }
        
        return cell
    }
    
    
}
