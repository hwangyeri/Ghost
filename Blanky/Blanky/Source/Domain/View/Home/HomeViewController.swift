//
//  HomeViewController.swift
//  Blanky
//
//  Created by Yeri Hwang on 2023/11/30.
//

import UIKit
import RxSwift
import RxCocoa
import Kingfisher

final class HomeViewController: BaseViewController {
    
    /*
     Cursor-based Pagination (게시글 조회 API)
     1. 초기 데이터 로드: 처음에는 cursor 빈값으로 전달, postRead 메서드 호출
     2. 다음 페이지 처리: 응답 데이터의 next_cursor 값 cursor 매개변수로 전달, 다음 페이지의 데이터 가져오기
     3. 데이터 소스 업데이트: 새롭게 받아온 새 게시물 데이터 postDataList에 추가
     4. 새 게시글 표시를 위한 TableView Reload
     */
    
    private let mainView = HomeView()
    
    private let viewModel = HomeViewModel()
    
    let disposeBag = DisposeBag()
    
    private var postDataList = PostRead(data: [], next_cursor: "")
    
    override func loadView() {
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        postDataList.data.removeAll()
        postRead(cursor: "") // 1. 초기 데이터 로드
    }
    
    override func configureLayout() {
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        mainView.tableView.prefetchDataSource = self
    }
    
    private func postRead(cursor: String) {
        print(#function)
        
        // 더이상 로드할 데이터 없을 시 예외처리
        guard cursor != "0" else {
            print("더이상 로드 할 데이터가 없습니다.")
            return
        }
        
        // 게시글 조회 API
        PostAPIManager.shared.postRead(next: cursor)
            .subscribe(with: self) { [weak self] _, result in
                switch result {
                case .success(let data):
                    print("포스트 조회 성공")
                    
                    // 3. 데이터 소스 업데이트
                    self?.postDataList.data.append(contentsOf: data.data)
                    self?.postDataList.next_cursor = data.next_cursor
                    
                    // 4. 테이블뷰 리로드
                    self?.mainView.tableView.reloadData()
                    
                case .failure(let error):
                    print("포스트 조회 실패: ", error)
                }
            }
            .disposed(by: disposeBag)
    }
    
    private func prefetchData(for indexPaths: [IndexPath]) {
        guard let lastIndexPath = indexPaths.last else {
            return
        }
        
        let lastIndex = lastIndexPath.row
        let totalCount = postDataList.data.count
        
        if lastIndex >= totalCount - 3 {
            // 2. 다음 페이지 처리
            postRead(cursor: postDataList.next_cursor)
        }
    }
    
    private func bind() {
        
        let input = HomeViewModel.Input(
            plusButton: mainView.plusButton.rx.tap,
            profileButton: mainView.profileButton.rx.tap
        )
        
        let output = viewModel.transform(input: input)
        
        output.plusButtonTap
            .drive(with: self) { owner, _ in
                let vc = PostViewController()
                owner.navigationController?.pushViewController(vc, animated: true)
            }
            .disposed(by: disposeBag)
        
        output.profileButtonTap
            .drive(with: self) { owner, _ in
                let vc = ProfileViewController()
                owner.navigationController?.pushViewController(vc, animated: true)
            }
            .disposed(by: disposeBag)
    }

}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return "header Test"
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postDataList.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier, for: indexPath) as? HomeTableViewCell else { return UITableViewCell() }
        let row = postDataList.data[indexPath.row]
        
        cell.postData = row // PostData 값 전달
        
        cell.nicknameLabel.text = row.creator.nick //"익명의유령\(indexPath.row)"
        cell.dateLabel.text = row.time
        cell.titleLabel.text = row.title
        cell.contentLabel.text = row.content
        cell.messageLabel.text = "\(row.comments.count)"
        cell.likeLabel.text = "\(row.likes.count)"
        
        return cell
    }
   
}

extension HomeViewController: UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            print("prefetchRowsAt: \(indexPath.row)")
        }
        
        prefetchData(for: indexPaths)
    }
    
    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            print("cancelPrefetchingForRowsAt \(indexPath.row)")
        }
    }
    
}
