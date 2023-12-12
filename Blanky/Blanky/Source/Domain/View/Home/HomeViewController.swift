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
    
    private let mainView = HomeView()
    
    private let viewModel = HomeViewModel()
    
    let disposeBag = DisposeBag()
    
    private var postDataList = PostRead(data: [], next_cursor: "")
    
    override func loadView() {
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
//        postRead()
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        postRead()
    }
    
    override func configureLayout() {
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
    }
    
    private func postRead() {
        // 게시글 조회 API
        PostAPIManager.shared.postRead(next: "", limit: "5")
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier, for: indexPath) as? HomeTableViewCell else { return UITableViewCell() }
        let row = postDataList.data[indexPath.row]
        
        cell.nicknameLabel.text = row.creator.nick //"익명의유령\(indexPath.row)"
        cell.dateLabel.text = row.time
        cell.titleLabel.text = row.title
        cell.contentLabel.text = row.content
        cell.messageLabel.text = "\(row.comments.count)"
        cell.likeLabel.text = "\(row.likes.count)"
        
        cell.collectionView.delegate = self
        cell.collectionView.dataSource = self
       
        return cell
    }
    
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.identifier, for: indexPath) as? HomeCollectionViewCell else { return UICollectionViewCell() }

        let modifier = AnyModifier { request in
            var headers = request
            
            // 헤더 설정
            headers.setValue(KeychainManager.shared.token, forHTTPHeaderField: Constant.authorization)
            headers.setValue(APIKey.sesacKey, forHTTPHeaderField: Constant.sesacKey)
            
            return headers
        }
        
        for index in 0..<postDataList.data.count {
            let imageURL = postDataList.data[index].image[indexPath.row]
            print("++++++++++++ imageURL: ", imageURL)
            
            cell.imageView.kf.setImage(
                with: URL(string: APIKey.baseURL + imageURL),
                placeholder: UIImage(named: "ghost"),
                options: [.requestModifier(modifier)]
            )
        }
        
        return cell
    }
    
    
}
