//
//  JoinViewController.swift
//  Blanky
//
//  Created by Yeri Hwang on 2023/11/16.
//

import UIKit
import RxSwift
import RxCocoa

class JoinStep1ViewController: BaseViewController {
    
    private let mainView = JoinStep1View()
    
    private let viewModel = JoinStep1ViewModel()
    
    private let disposeBag = DisposeBag()
    
    override func loadView() {
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
    }
    
    override func configureLayout() {
        self.navigationItem.title = "회원가입"
        setCustomBackButton()
    }
    
    private func bind() {
        
        let input = JoinStep1ViewModel.Input(
            emailTextField: mainView.emailTextField.rx.text.orEmpty,
            checkEmailDuplicationButton: mainView.checkEmailDuplicationButton.rx.tap,
            passwordTextField: mainView.passwordTextField.rx.text.orEmpty,
            checkPasswordTextField: mainView.checkPasswordTextField.rx.text.orEmpty,
            nextButton: mainView.nextButton.rx.tap)
        
        let output = viewModel.transform(input: input)
        
        output.emailValidation
            .drive(with: self) { owner, isValid in
                owner.mainView.emailTextField.borderActiveColor = isValid ? .point : .systemPink
                owner.mainView.checkEmailDuplicationButton.isEnabled = isValid
                owner.mainView.checkEmailDuplicationButton.backgroundColor = isValid ? .white : .gray
            }
            .disposed(by: disposeBag)
        
        output.passwordValidation
            .drive(with: self) { owner, isValid in
                owner.mainView.passwordTextField.borderActiveColor = isValid ? .point : .systemPink
            }
            .disposed(by: disposeBag)
        
        output.checkPasswordValidation
            .drive(with: self) { owner, isValid in
                owner.mainView.checkPasswordTextField.borderActiveColor = isValid ? .point : .systemPink

            }
            .disposed(by: disposeBag)
        
        output.checkEmailDuplicationResult
            .drive(with: self) { owner, result in
                //owner.showAlertMessage(title: result.0, message: result.1)
                owner.mainView.emailInfoLabel.text = result.1
            }
            .disposed(by: disposeBag)
        
        output.finalValidation
            .drive(with: self) { owner, isValid in
                owner.mainView.nextButton.isEnabled = isValid
                owner.mainView.nextButton.backgroundColor = isValid ? .white : .gray
            }
            .disposed(by: disposeBag)
        
        output.nextButtonTap
            .drive(with: self) { owner, result in
                switch result.0 {
                case true:
                    let vc = JoinStep2ViewController()
                    vc.userInfo = result.1
                    owner.navigationController?.pushViewController(vc, animated: true)
                case false:
                    owner.mainView.emailInfoLabel.text = "✅  사용 가능한 이메일인지 확인해 주세요."
                    owner.showAlertMessage(title: "", message: "사용 가능한 이메일인지 확인해 주세요.")
                }
            }
            .disposed(by: disposeBag)
    }

}
