//
//  FirstSwipeViewController.swift
//  Blanky
//
//  Created by Yeri Hwang on 2023/12/20.
//

import UIKit
import RxSwift
import RxCocoa

final class FirstSwipeViewController: BaseViewController {
    
    private let mainView = FirstSwipeView()
    
    private var myData = PostRead(data: [], next_cursor: "")
    
    private let disposeBag = DisposeBag()

    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        userPostRead()
    }
    
    override func configureLayout() {
        view.backgroundColor = .bColor200
        mainView.tableView.dataSource = self
        mainView.tableView.delegate = self
    }
    
    private func showLoadingIndicator() {
        mainView.loadingIndicator.startAnimating()
    }
    
    private func hideLoadingIndicator() {
        mainView.loadingIndicator.stopAnimating()
        mainView.loadingIndicator.isHidden = true
    }
    
    private func userPostRead() {
        showLoadingIndicator()

        // 유저별 작성한 게시글 조회 API
        PostAPIManager.shared.postUser(id: KeychainManager.shared.userID ?? "userID Error", next: "")
            .subscribe(with: self) { owner, result in
                switch result {
                case .success(let data):
                    print("유저별 작성한 게시글 조회 성공")
                    owner.myData = data
                    owner.mainView.tableView.reloadData()
                case .failure(let error):
                    print("유저별 작성한 게시글 조회 실패: ", error.errorDescription)
                }
            }
            .disposed(by: disposeBag)
    }
    
}

extension FirstSwipeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myData.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FirstSwipeTableViewCell.identifier, for: indexPath) as? FirstSwipeTableViewCell else { return UITableViewCell() }
        let row = myData.data[indexPath.row]
        
        cell.titleLabel.text = row.title
        cell.dateLabel.text = row.time
        cell.commentButton.setTitle("\(row.comments.count)", for: .normal)
        
        // 프로필 이미지가 있는 경우
        if !row.image.isEmpty {
            // 이미지 로드 + 다운샘플링
            cell.postImageView.setImage(withURL: row.image[0], downsamplingSize: cell.postImageView.bounds.size) { result in
                switch result {
                case .success(_):
                    print("🩵 이미지 로드 성공")
                    break
                case .failure(let error):
                    print("💛 이미지 로드 실패: \(error)")
                }
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        let postID = myData.data[indexPath.row]._id
        vc.postID = postID
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
