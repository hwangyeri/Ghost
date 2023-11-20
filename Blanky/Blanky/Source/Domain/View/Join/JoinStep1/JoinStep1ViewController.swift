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
    
    let disposeBag = DisposeBag()
    
    override func loadView() {
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        bind()
    }
    
    override func configureLayout() {
        self.navigationItem.title = "회원가입"
        mainView.checkDuplicationButton.addTarget(self, action: #selector(checkDuplicationButtonTapped), for: .touchUpInside)
    }
    
    @objc private func checkDuplicationButtonTapped() {
        print(#function)
    }
    
    private func bind() {
        
        let input = JoinStep1ViewModel.Input(
            emailTextField: mainView.emailTextField.rx.text.orEmpty,
            passwordTextField: mainView.passwordTextField.rx.text.orEmpty,
            checkPasswordTextField: mainView.checkPasswordTextField.rx.text.orEmpty,
            checkDuplicationButton: mainView.checkDuplicationButton.rx.tap,
            nextButton: mainView.nextButton.rx.tap)
        
        let output = viewModel.transform(input: input)
        
        output.emailValidation
            .drive(with: self) { owner, isValid in
                owner.mainView.emailTextField.borderActiveColor = isValid ? .point : .systemPink
                owner.mainView.checkDuplicationButton.isEnabled = isValid
                owner.mainView.checkDuplicationButton.backgroundColor = isValid ? .white : .gray
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
        
    }

}
