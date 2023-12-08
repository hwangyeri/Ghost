//
//  HomeViewController.swift
//  Blanky
//
//  Created by Yeri Hwang on 2023/11/30.
//

import UIKit
import RxSwift
import RxCocoa

final class HomeViewController: BaseViewController {
    
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
        postRead()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        postRead()
    }
    
    override func configureLayout() {
        self.navigationItem.hidesBackButton = true
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
    }
    
    private func postRead() {
        // 게시글 조회 API
        PostAPIManager.shared.postRead(next: "", limit: "20")
            .subscribe(with: self) { [weak self] _, result in
                print("네트워크 통신 결과: ", result)
                switch result {
                case .success(let data):
                    print("포스트 조회 성공: ", data)
                    
                    self?.postDataList = data
                    self?.mainView.tableView.reloadData()
                case .failure(let error):
                    print("포스트 조회 실패: ", error)
                }
            }
            .disposed(by: disposeBag)
    }
    
    private func bind() {
        
        let input = HomeViewModel.Input(
            plusButton: mainView.plusButton.rx.tap)
        
        let output = viewModel.transform(input: input)
        
        output.plusButtonTap
            .drive(with: self) { owner, _ in
                let vc = PostViewController()
                owner.navigationController?.pushViewController(vc, animated: true)
            }
            .disposed(by: disposeBag)
    }

}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "header Test"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postDataList.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier, for: indexPath) as? HomeTableViewCell else { return UITableViewCell()}
        let row = postDataList.data[indexPath.row]
        
        cell.nicknameLabel.text = "익명의유령\(indexPath.row)"
        cell.dateLabel.text = row.time
        cell.titleLabel.text = row.title
        cell.contentLabel.text = row.content
        cell.messageLabel.text = "\(row.comments.count)"
        cell.likeLabel.text = "\(row.likes.count)"
       
        return cell
    }
    
}
