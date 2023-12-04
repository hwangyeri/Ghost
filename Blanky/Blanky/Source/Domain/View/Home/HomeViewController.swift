//
//  HomeViewController.swift
//  Blanky
//
//  Created by Yeri Hwang on 2023/11/30.
//

import UIKit
import RxSwift
import RxCocoa

class HomeViewController: BaseViewController {
    
    private let mainView = HomeView()
    
    private let viewModel = HomeViewModel()
    
    let disposeBag = DisposeBag()
    
    private let dummy: [PostData] = [
        PostData(likes: [], image: [], hashTags: [], comments: [], id: "", productID: "", creator: Creator(id: "", nick: "nick1", profile: "ghost"), time: "", title: "title1", content: "content1"),
        PostData(likes: [], image: [], hashTags: [], comments: [], id: "", productID: "", creator: Creator(id: "", nick: "nick2", profile: "ghost"), time: "", title: "title2", content: "content2"),
        PostData(likes: [], image: [], hashTags: [], comments: [], id: "", productID: "", creator: Creator(id: "", nick: "nick3", profile: "ghost"), time: "", title: "title3", content: "content3")
    ]
    
    override func loadView() {
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        bind()
    }
    
    override func configureLayout() {
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
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
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier, for: indexPath) as? HomeTableViewCell else { return UITableViewCell()}
       
        return cell
    }
    
}
