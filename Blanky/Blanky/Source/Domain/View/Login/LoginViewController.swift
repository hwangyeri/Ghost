//
//  LoginViewController.swift
//  Blanky
//
//  Created by Yeri Hwang on 2023/11/16.
//

import UIKit
import RxSwift
import RxCocoa

class LoginViewController: BaseViewController {
    
    private let mainView = LoginView()
    
    private let viewModel = LoginViewModel()
    
    private let disposeBag = DisposeBag()
    
    override func loadView() {
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
    }
    
    private func bind() {
        
        let input = LoginViewModel.Input(
            emailTextField: mainView.emailTextField.rx.text.orEmpty,
            passwordTextField: mainView.passwordTextField.rx.text.orEmpty,
            loginButton: mainView.loginButton.rx.tap,
            findEmailButton: mainView.findEmailButton.rx.tap,
            findPasswordButton: mainView.findPasswordButton.rx.tap,
            joinButton: mainView.joinButton.rx.tap)
        
        let output = viewModel.transform(input: input)
        
        output.emailValidation
            .drive(with: self) { owner, isValid in
                owner.mainView.emailTextField.borderActiveColor = isValid ? .point : .systemPink
            }
            .disposed(by: disposeBag)
        
        output.passwordValidation
            .drive(with: self) { owner, isValid in
                owner.mainView.passwordTextField.borderActiveColor = isValid ? .point : .systemPink
            }
            .disposed(by: disposeBag)
        
        output.finalValidation
            .drive(with: self) { owner, isValid in
                owner.mainView.loginButton.isEnabled = isValid
                owner.mainView.loginButton.backgroundColor = isValid ? .white : .gray
            }
            .disposed(by: disposeBag)
        
        output.loginButtonTap
            .drive(with: self) { owner, result in
                switch result.0 {
                case true:
                    // 로그인 성공 시 InitialView로 화면전환
                    let vc = InitialViewController()
                    RootVCManager.shared.changeRootVC(vc)
                case false:
                    owner.showAlertMessage(title: "", message: result.1)
                }
            }
            .disposed(by: disposeBag)
        
        output.joinButtonTap
            .drive(with: self) { owner, _ in
                let vc = JoinStep1ViewController()
                owner.navigationController?.pushViewController(vc, animated: true)
            }
            .disposed(by: disposeBag)
        
        NotificationCenter.default.rx.notification(.joinSuccessAlert)
            .observe(on: MainScheduler.instance)
            .subscribe(with: self) { owner, notification in
                if let email = notification.userInfo?["email"] as? String {
                    owner.showAlertMessage(title: email, message: "성공적으로 가입되었습니다.\n가입한 이메일로 로그인해주세요.")
                }
            }
            .disposed(by: disposeBag)
        
//        NotificationCenter.default.rx.notification(.tokenRefreshFailedAlert)
//            .observe(on: MainScheduler.instance)
//            .subscribe(with: self) { owner, notification in
//                owner.showAlertMessage(title: "", message: "장기간 움직임이 없어 로그아웃 되었습니다.\n다시 로그인해 주세요.")
//            }
//            .disposed(by: disposeBag)
    }
    
}
