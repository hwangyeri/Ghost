//
//  DetailViewController.swift
//  Blanky
//
//  Created by Yeri Hwang on 2023/12/14.
//

import UIKit
import RxSwift
import RxCocoa

protocol PostTableViewCellDelegate: AnyObject {
    func likeButtonTapped()
}

final class DetailViewController: BaseViewController {
    
    private let mainView = DetailView()
    
    private let viewModel = DetailViewModel()
    
    private let disposeBag = DisposeBag()
    
    private var postData = PostData(likes: [], image: [], comments: [], _id: "", time: "", creator: Creator(_id: "", nick: ""), title: "", content: "", product_id: "")
    
    var postID: String?
    
    var isLiked: Bool = false
    
    override func loadView() {
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setRightButton()
        onePostRead()
        bind()
    }
    
    override func configureLayout() {
        self.tabBarController?.tabBar.isHidden = true
        setCustomBackButton()
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
    }
    
    // 메뉴 버튼 (네비바 오른쪽)
    func setRightButton() {
        let rightButton = GImageButton(imageSize: 16, imageName: Constant.ellipsis, backgroundColor: .bColor200, tintColor: .white, cornerRadius: 15).then {
            let imageConfig = UIImage.SymbolConfiguration(pointSize: 16, weight: .semibold)
            let image = UIImage(systemName: Constant.ellipsis, withConfiguration: imageConfig)
            
            $0.setImage(image, for: .normal)
        }
        
        rightButton.addTarget(self, action: #selector(rightButtonTapped), for: .touchUpInside)
        
        rightButton.snp.makeConstraints { make in
            make.size.equalTo(42)
        }
        
        let customButton = UIBarButtonItem(customView: rightButton)
        
        self.navigationItem.rightBarButtonItem = customButton
    }
    
    @objc func rightButtonTapped() {
        print(#function)
    }
    
    private func showLoadingIndicator() {
        mainView.loadingIndicator.startAnimating()
    }
    
    private func hideLoadingIndicator() {
        mainView.loadingIndicator.stopAnimating()
        mainView.loadingIndicator.isHidden = true
    }
    
    private func onePostRead() {
        showLoadingIndicator()
        
        guard let postID = self.postID else {
            print("postID Error")
            return
        }
        
        // 특정 게시글 조회 API
        PostAPIManager.shared.onePostRead(id: postID)
            .subscribe(with: self) { owner, result in
                owner.hideLoadingIndicator()
                switch result {
                case .success(let data):
                    print("특정 게시글 조회 성공")
                    owner.postData = data
                    // 댓글 순서 바꾸기
                    owner.postData.comments.sort { $0.time < $1.time }
                    // 좋아요 버튼 이미지 설정
                    owner.isLiked = owner.postData.likes.contains(KeychainManager.shared.userID ?? "userID Error")
                    // 테이블뷰 리로드
                    owner.mainView.tableView.reloadData()
                case .failure(let error):
                    print("특정 게시글 조회 실패: ", error.errorDescription)
                }
            }
            .disposed(by: disposeBag)
    }
    
    private func bind() {
        guard let postID = self.postID else {
            print("postID Error")
            return
        }
        
        let input = DetailViewModel.Input(
            postID: postID,
            contentTextField: mainView.contentTextField.rx.text.orEmpty,
            writeButton: mainView.writeButton.rx.tap,
            topScrollButton: mainView.topScrollButton.rx.tap
        )
        
        let output = viewModel.transform(input: input)
        
        output.contentTextFieldValidation
            .drive(with: self) { owner, isValid in
                owner.mainView.writeButton.isEnabled = isValid
            }
            .disposed(by: disposeBag)
        
        output.writeButtonTap
            .drive(with: self) { owner, result in
                switch result {
                case true:
                    owner.mainView.contentTextField.text = "" // 텍스트 초기화 
                    owner.onePostRead()
                    
                    // 댓글 작성시 맨 아래로 스크롤
                    guard !owner.postData.comments.isEmpty else { return }
                    let lastCommentIndexPath = IndexPath(row: owner.postData.comments.count - 1, section: 1)
                    owner.mainView.tableView.scrollToRow(at: lastCommentIndexPath, at: .bottom, animated: true)
                    
                case false:
                    owner.showAlertMessage(title: "", message: "댓글 작성에 실패했습니다.\n다시 시도해 주세요.")
                }
            }
            .disposed(by: disposeBag)
        
        output.topScrollButtonTap
            .drive(with: self) { owner, _ in
                let topIndexPath = IndexPath(row: 0, section: 0)
                owner.mainView.tableView.scrollToRow(at: topIndexPath, at: .top, animated: true)
            }
            .disposed(by: disposeBag)
    }

}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
 
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 1:
            return CustomHeaderView()
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 1:
            return postData.comments.count
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.identifier, for: indexPath) as? PostTableViewCell else { return UITableViewCell() }
            let data = postData
            
            cell.titleLabel.text = data.title
            cell.contentLabel.text = data.content
            
            let time = Date().timeAgo(from: data.time)
            cell.dateLabel.text = time
            
            cell.likeLabel.text = "\(data.likes.count)"
            cell.messageLabel.text = "\(data.comments.count)"
            cell.likeButton.setImage(UIImage(systemName: isLiked ? Constant.heartFill : Constant.heart), for: .normal)
            cell.likeButton.tintColor = isLiked ? .point : .white
            
            // 대리자 설정
            cell.delegate = self
            cell.postData = data
            
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CommentTableViewCell.identifier, for: indexPath) as? CommentTableViewCell else { return UITableViewCell() }
            let row = postData.comments[indexPath.row]
            
            cell.commentLabel.text = row.content
            
            let time = Date().timeAgo(from: row.time)
            cell.dateLabel.text = time
            
            // 댓글 작성자 아닌 경우, 삭제 버튼 히든 처리
            cell.deleteButton.isHidden = row.creator._id != KeychainManager.shared.userID
            
            return cell
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.identifier, for: indexPath) as? PostTableViewCell else { return UITableViewCell() }
            return cell
        }
    }
    
    
}

extension DetailViewController: PostTableViewCellDelegate {
    
    // Cell 안에 좋아요 버튼 클릭 이벤트 처리
    func likeButtonTapped() {
        print(#function)
        
        guard let postID = self.postID else {
            print("postID Error")
            return
        }
        
        // 게시글 좋아요 API
        PostAPIManager.shared.like(id: postID)
            .subscribe(with: self) { owner, result in
                switch result {
                case .success(let data):
                    owner.isLiked = data.like_status
                    //섹션 리로드
                    owner.mainView.tableView.reloadSections(IndexSet(0...0), with: .automatic)
                case .failure(let error):
                    print(error.errorDescription)
                }
            }
            .disposed(by: disposeBag)
    }
    
}
