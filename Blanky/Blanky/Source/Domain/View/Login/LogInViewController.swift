//
//  LogInViewController.swift
//  Blanky
//
//  Created by Yeri Hwang on 2023/11/16.
//

import UIKit

class LogInViewController: BaseViewController {
    
    private let mainView = LogInView()
    
    override func loadView() {
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func configureLayout() {
        mainView.joinButton.addTarget(self, action: #selector(joinButtonTapped), for: .touchUpInside)
    }
    
    // MARK: 회원가입 버튼
    @objc private func joinButtonTapped() {
        print(#function)
        let vc = JoinStep1ViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
