//
//  PasswordStepViewController.swift
//  Blanky
//
//  Created by Yeri Hwang on 2023/11/18.
//

import UIKit
import RxSwift
import RxCocoa

class JoinStep2ViewController: BaseViewController {
    
    private let mainView = JoinStep2View()
    
    private let viewModel = JoinStep2ViewModel()
    
    var userInfo: JoinInput?
    
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
        setCustomExitButton()
    }
    
    private func bind() {
        
        let input = JoinStep2ViewModel.Input(
            useInfo: userInfo ?? JoinInput(email: "", password: "", nick: ""),
            nicknameTextField: mainView.nicknameTextField.rx.text.orEmpty,
            randomButton: mainView.randomButton.rx.tap,
            doneButton: mainView.doneButton.rx.tap)
        
        let output = viewModel.transform(input: input)
        
        output.nicknameValidation
            .drive(with: self) { owner, isValid in
                owner.mainView.nicknameTextField.borderActiveColor = isValid ? .point : .systemPink
                owner.mainView.doneButton.isEnabled = isValid
                owner.mainView.doneButton.backgroundColor = isValid ? .white : .gray
            }
            .disposed(by: disposeBag)
        
        output.randomButtonTap
            .drive(with: self) { owner, nickname in
                owner.mainView.nicknameTextField.text = nickname
                owner.mainView.nicknameTextField.borderActiveColor = .point
                owner.mainView.doneButton.isEnabled = true
                owner.mainView.doneButton.backgroundColor = .white
            }
            .disposed(by: disposeBag)
        
        output.doneButtonTap
            .drive(with: self) { owner, result in
                print(result)
                switch result {
                case true:
                    guard let email = self.userInfo?.email else {
                        print("email Error")
                        return
                    }
                    
                    owner.navigationController?.popToRootViewController(animated: true)
                    NotificationCenter.default.post(name: .joinSuccessAlert, object: nil, userInfo: ["email": email])
                case false:
                    owner.showAlertMessage(title: "", message: "다시 시도해 주세요.")
                }
            }
            .disposed(by: disposeBag)
    }
    
}
